/*import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluenzo/Articles/Screens/ArticlesCreation.dart';
import 'package:fluenzo/Authentication/DataServices/SignupDatabase.dart';
import 'package:fluenzo/Common/Helper/AddPhotoToDatabase.dart';
import 'package:fluenzo/Common/Helper/firebaseError.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? profilePic;
  bool passwordBool = false;
  bool loginPasswordBool = false;
  bool reEnterPasswordBool = false;
  bool uploadingUserDetails = false;
  bool? userNameChecker = false;

  Future registerWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.reload();
    } catch (e) {
      print(e.toString());
      showError(context, e.toString());
    }
  }

  Future loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      userCredential.user!.reload();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ArticlesCreation()));
    } catch (e) {
      print(e.toString());
      showError(context, e.toString());
    }
  }

  getPhoto() async {
    profilePic = await getImage();
    notifyListeners();
  }

  getPasswordBool() {
    passwordBool = !passwordBool;
    notifyListeners();
  }

  getLoginPasswordBool() {
    loginPasswordBool = !loginPasswordBool;
    notifyListeners();
  }

  getuploadinguserData() {
    uploadingUserDetails = true;
    notifyListeners();
  }

  getReEnterPasswordBool() {
    reEnterPasswordBool = !reEnterPasswordBool;
    notifyListeners();
  }

  getUserNameChecker(
      BuildContext context,
      bool val,
      var authProvider,
      String passwordController,
      String reEnterPasswordController,
      String emailController,
      String nameController,
      String userNameController,
      String mobileNumberController) {
    print('nnn getting $val');

    if (val == false) {
      showError(context, 'Mobile Number is Already in Use');
    }
    if (val == true) {
      if (passwordController == reEnterPasswordController) {
        if (authProvider.profilePic != null) {
          authProvider.getuploadinguserData();
          authProvider
              .registerWithEmailAndPassword(
                  context, emailController, passwordController)
              .then((value) => {
                    FirebaseAuth.instance.currentUser!.reload(),
                    AuthenticationDatabase()
                        .addPhoto(
                            authProvider.profilePic!,
                            emailController,
                            nameController,
                            userNameController,
                            mobileNumberController)
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticlesCreation(),
                            )))
                  });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please Add profile photo'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Entered Password not Matching'),
        ));
      }
    }

    userNameChecker = val;
    notifyListeners();
  }
}

*/
