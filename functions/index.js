const functions = require("firebase-functions");
const admin = require('firebase-admin');
const { firestore } = require("firebase-admin");
const { database } = require("firebase-functions/v1/firestore");

admin.initializeApp();

var msgData ;
var deviceTokens =[];
var tokens =[];

/*exports.articleNotificationTrigger = functions.firestore.document('ArticlesCollection/{articleid}')
.onCreate((snapshot,context)=> {
    msgData = snapshot.data();

    return admin.firestore().collection('GeneralAppUserNotificationToken').get().then((snapshots)=>{
        var tokens =[];
        if(snapshots.empty){
            return false;
            console.log('No Devices');
        }else{
            for(var token of snapshots.docs){
                tokens.push(token.data().NotificationToken);
            }

            var payLoad = {"notification":{"title":msgData.ArticleTitle,
                                            "body":"New Article From "+ msgData.AuthorName,
                                            "sound":"default"},
                            "data":{"sendername":msgData.AuthorName,"message":msgData.ArticleTitle}}

        return admin.messaging().sendToDevice(tokens,payLoad).then((response)=>{
                console.log('Pushed Them All');

        }).catch((e)=>{
            console.log(e);
        });                    

        }

    });
});*/

exports.newUpdateArticleNotificationTrigger01 = functions.firestore.document('ArticlesCollection/{articleid}')
.onUpdate((snapshot,context)=> {
    msgData = snapshot.after.data();
    console.log(msgData);
    if(msgData.SentNotificatonForPublished == "False"){
if(msgData.IsArticlePublished === "Published"){
  //  FirebaseFirestore.collection('Userdummy').doc().set({'d':'dddd'});
  //FirebaseFirestore.collection('nes').doc('we').se
  //database.collection('nrew').doc('new').set({"hi":hi});
  admin.firestore().collection('ArticlesCollection').doc(msgData.DocumentId).update({"SentNotificatonForPublished":"True"});
    return admin.firestore().collection('GeneralAppUserNotificationToken').get().then((snapshots)=>{
        var tokens =[];
        if(snapshots.empty){
            console.log('No Devices');
            return false;
        }else{
            for(var token of snapshots.docs){
                tokens.push(token.data().NotificationToken);
            }

            var payLoad = {
                "notification":{"title":msgData.ArticleTitle,"body":"New Article From "+ msgData.AuthorName,"sound":"default","click_action": "FLUTTER_NOTIFICATION_CLICK",},
                            "data":{"sendername":msgData.AuthorName,"message":msgData.ArticleTitle,"screen": "/ArticleDetail",
                            "docid":msgData.DocumentId}}

        return admin.messaging().sendToDevice(tokens,payLoad).then((response)=>{
                tokens =[];
                console.log('Pushed Them All');

        }).catch((e)=>{
            console.log(e);
        });                    

        }

    });}else{
        console.log('Edit Happened In Article But Not Published');
        return false;
    }}else{
        console.log('Edit Happened In Article notification sent once');
        return false;
    }
});


exports.newAuthorWellcomeNotification = functions.firestore.document('UserProfile/{userid}')
.onUpdate(async (snapshot,context)=> {
    msgData = snapshot.after.data();
    console.log(msgData);
    if(msgData.RequestAuthor == "True"){
if(msgData.Role === "ContentWriter"){
  //  FirebaseFirestore.collection('Userdummy').doc().set({'d':'dddd'});
  //FirebaseFirestore.collection('nes').doc('we').se
  //database.collection('nrew').doc('new').set({"hi":hi});
  admin.firestore().collection('UserProfile').doc(msgData.UserUid).update({"RequestAuthor":"False"});
    //return admin.firestore().collection('GeneralAppUserNotificationToken').get().then((snapshots)=>{
      //  var tokens =[];
       // if(snapshots.empty){
         //   console.log('No Devices');
           // return false;
       // }else{
         //   for(var token of snapshots.docs){
             //   tokens.push(token.data().NotificationToken);
           // }

           tokens.push(msgData.NotificationToken);

            var payLoad = {"notification":{"title":"Hello "+msgData.Name,"body":"Your Author Request Got Approved..!","image":"https://firebasestorage.googleapis.com/v0/b/journzsocialnetwork.appspot.com/o/Articles%2FAwarness%2Fimage_cropper_1631204023660.jpg?alt=media&token=ae694635-91a1-4d8b-aa23-274bf79480bd","sound":"default","click_action": "FLUTTER_NOTIFICATION_CLICK"},
                            "data":{"sendername":msgData.Name,"message":msgData.Name,"screen":'/UserProfile',}}

        try {
        const response = await admin.messaging().sendToDevice(tokens, payLoad);
        tokens =[];
        console.log('Pushed Them All');
    } catch (e) {
        console.log(e);
    }                    

        }}});
/* 
    });}else{
       console.log('Edit Happened In Article But Not Published');
        return false;
    }}else{
        console.log('Edit Happened In Article notification sent once');
        return false;
   }
});
 */


















/*
exports.subscriptionBasedNotification = functions.firestore.document('ArticlesCollection/{articleid}')
.onUpdate((snapshot,context)=> {
    msgData = snapshot.after.data();
  //  console.log(msgData);
    if(msgData.SentNotificatonForPublished == "False"){
    if(msgData.IsArticlePublished === "Published"){
        admin.firestore().collection('ArticlesCollection').doc(msgData.DocumentId).update({"SentNotificatonForPublished":"True"});
        console.log('Starting to get Device Token');
        return admin.firestore().collection('ArticleSubtype').where("SubType","==",msgData.ArticleSubType).get().then((listenedValue)=>{
        console.log('Landed On A Document');
            if(listenedValue.size != 0){
                console.log('Starting to pass Document Id');
                console.log(listenedValue.docs[0].id);
                return admin.firestore().collection('ArticleSubtype').doc(listenedValue.docs[0].id).get().then((listenField)=>{
                console.log('got Device Token List');
                
                //Int i = 0;
                console.log(listenField.data().PeopleSubscribed);
                tokens = listenField.data().PeopleSubscribed;
                if(tokens==[]){
                    console.log('No Devices Record Found');
                    return false;
                }else{

                console.log(tokens);
              /*      for (const entry of tokens) {
                        for (const [key, v] of Object.entries(tokens)) {
                            
                            console.log('key value ');
                            console.log(key);
                            console.log(v);

                        }
                    }* prevoius comment here

                for(i = 0;i<= tokens.length-1;i++){
                    console.log(i);
                    console.log(tokens[i].Token);
                    deviceTokens.push(tokens[i].Token);
                    console.log(deviceTokens);
                 //   for( var i of tokens){
                   // deviceTokens.push(i.NotificationToken);
                }

            var payLoad = {"notification":{"title":msgData.ArticleTitle,
                                            "body":"New Article From "+ msgData.AuthorName,
                                            "sound":"default",
                                            "time_to_live": "600",
                                            },
                                            
                                            
                                              
                            "data":{"sendername":msgData.AuthorName,
                                    "message":msgData.ArticleTitle,
                                    "click_action": "FLUTTER_NOTIFICATION_CLICK",
                                    "sound":"default",
                                    "status": "done",
                                    "screen": "/NotificationScreen",
                                    "docid":msgData.DocumentId}}

            return admin.messaging().sendToDevice(deviceTokens,payLoad).then((response)=>{
                console.log('Pushed Them All');
                deviceTokens =[];

            }).catch((e)=>{
            console.log(e);
            });                    

            }});

            }else{
                console.log('No Document Found For %s',msgData.ArticleSubType);
                return false;
            }

            });}else{
                console.log('Edit Happened In Article But Not Published');
                return false;
            }}else{
                console.log('Edit Happened In Article notification sent once');
                return false;
            }
            });*/

