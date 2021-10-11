import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Authentication/DataModel/SignUpDataModel.dart';
import '/Authentication/Screens/VerifyEmail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupDataBase {
  checkUserName(String userName) async {
    print('nnn username $userName');
    return await FirebaseFirestore.instance
        .collection('UserName')
        .where('UserName', isEqualTo: userName)
        .get();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  createUserWithEmailAndPassword(
      UserCredential userCredential,
      String firstName,
      String lastName,
      String name,
      String userName,
      String mobileNumber,
      String token,
      PhoneAuthCredential credential,
      String email,
      String password,
      BuildContext context) async {
    try {
      //UserCredential userCredential = await _auth
      //  .createUserWithEmailAndPassword(email: email, password: password)
      // .whenComplete(() {});

      await userCredential.user!.reload();
      try {
        await userCredential.user!.linkWithCredential(credential).then((value) {
          String uid = FirebaseAuth.instance.currentUser!.uid;
          SignUpDataModel userProfileData = SignUpDataModel(
              notificationToken: token,
              role: 'User',
              firstName: firstName,
              lastName: lastName,
              email: email,
              disableTill: null,
              isDisable: 'False',
              noOfArticlesPostedByAuthor: 0,
              authorPermissionRequest: "False",
              mobileNumber: mobileNumber,
              name: name,
              isMobileNumberVerified: 'Verified',
              userName: userName,
              userFavouriteArticle: ["Social Issues"],
              photoUrl: 'images/fluenzologo.png',
              userUID: uid);
          FirebaseFirestore.instance
              .collection('GeneralAppUserNotificationToken')
              .doc(uid)
              .set({'NotificationToken': token});

          SignupDataBase().createUserProfile(uid, userProfileData.toJson());

          SignupDataBase()
              .createUserNameColl(uid, email, userName, mobileNumber);
          if (userCredential.user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
            );
          }
        }).onError((error, stackTrace) {
          if (FirebaseAuth.instance.currentUser != null) {
            print('nnn err dispose');
            // FirebaseAuth.instance.currentUser!.reload();
            //FirebaseAuth.instance.currentUser!.delete();
          }

          /*print('nnn error auth $error \n $stackTrace');
          String msg = error
              .toString()
              .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(msg.trim()),
          ));*/
          //   Navigator.pop(context);
          throw Exception("Enter Valid OTP");
        });
      } catch (e) {
        print('nnn wrong otp');
        String msg = e
            .toString()
            .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
        ));
      }
    } catch (e) {
      String msg = e
          .toString()
          .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
      ));
    }
  }

  createUserProfile(String uid, Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(uid)
        .set(data);
  }

  createUserNameColl(
      String uid, String email, String userName, String mobileNumber) async {
    return await FirebaseFirestore.instance.collection('UserName').doc().set(
        {'Email': email, 'UserName': userName, 'MobileNumber': mobileNumber});
  }
}
