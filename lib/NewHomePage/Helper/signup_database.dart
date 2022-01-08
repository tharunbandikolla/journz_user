import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journz_web/NewHomePage/Helper/signup_data_model.dart';

class SignupDataBase {
  checkUserName(String userName) async {
    print('nnn username $userName');
    return await FirebaseFirestore.instance
        .collection('UserName')
        .where('UserName', isEqualTo: userName)
        .get();
  }

  checkEmail(String email) async {
    print('nnn username $email');
    return await FirebaseFirestore.instance
        .collection('UserName')
        .where('Email', isEqualTo: email)
        .get();
  }

  checkMobileNumber(String mobileNumber) async {
    print('nnn username $mobileNumber');
    return await FirebaseFirestore.instance
        .collection('UserName')
        .where('MobileNumber', isEqualTo: mobileNumber)
        .get();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  createUserWithEmailAndPassword(
      String firstName,
      String lastName,
      String name,
      String userName,
      String mobileNumber,
      String token,
      String email,
      String password,
      String countryName,
      String countryCode,
      BuildContext context) async {
    try {
      //await userCredential.user!.reload();
      try {
        /* await userCredential.user!
            .linkWithCredential(credential)
            .then((value) async {
         */
        String uid = FirebaseAuth.instance.currentUser!.uid;
        SignUpDataModel userProfileData = SignUpDataModel(
            notificationToken: token,
            role: 'User',
            firstName: firstName,
            lastName: lastName,
            email: email,
            disableTill: null,
            countryCode: countryCode,
            countryName: countryName,
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

        SignupDataBase().createUserNameColl(uid, email, userName, mobileNumber);

        ///if (userCredential.user != null) {
        /*  SharedPreferences.getInstance().then((value) {
              FavArticleSharedPreferences()
                  .setFavCategories(["Social Issues"], value);
            */

        //  });
        // }
        /*  }).onError((error, stackTrace) {
          if (resetOtp != null) {
            resetOtp.reset!();
          }
 */
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Enter Valid OTP')));
//        });
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
    return await FirebaseFirestore.instance.collection('UserName').doc(uid).set(
        {'Email': email, 'UserName': userName, 'MobileNumber': mobileNumber});
  }
}
