import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginDatabase {
  checkExistingUserName(
    BuildContext context,
    String passwordController,
    String userNameController,
  ) async {
    print('nnn mobile called');
    return await FirebaseFirestore.instance
        .collection("UserName")
        .where("UserName", isEqualTo: userNameController)
        .get();
    /*
        .then((value) {
      if (value.size != 0) {
        value.docs.forEach((element) async {
          print('nnn mobile num ${element.data()['Email']}');
          try {
            await _auth
                .signInWithEmailAndPassword(
                    email: element.data()['Email'].toString(),
                    password: passwordController)
                .whenComplete(() async {
              FirebaseAuth.instance.currentUser?.reload();
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                      create: (context) =>
                                          ShowhidepasswordCubit()),
                                ],
                                child: HomeScreen(
                                  curIndex: 0,
                                ))));
              }
            });
          } catch (e) {
            String msg = e
                .toString()
                .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(msg),
            ));
          }
        });
      }
    });*/
  }

  checkExistingEmail(
    BuildContext context,
    String passwordController,
    String emailController,
  ) async {
    print('nnn mobile called');
    return await FirebaseFirestore.instance
        .collection("UserName")
        .where("Email", isEqualTo: emailController)
        .get();
    /*.then((value) {
      if (value.size != 0) {
        value.docs.forEach((element) async {
          print('nnn mobile num ${element.data()['Email']}');
          try {
            await _auth
                .signInWithEmailAndPassword(
                    email: element.data()['Email'].toString(),
                    password: passwordController)
                .whenComplete(() async {
              FirebaseAuth.instance.currentUser?.reload();
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                      create: (context) =>
                                          ShowhidepasswordCubit()),
                                ],
                                child: HomeScreen(
                                  curIndex: 0,
                                ))));
              }
            });
          } catch (e) {
            String msg = e
                .toString()
                .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(msg),
            ));
          }
        });
      }
    });*/
  }

  checkExistingMobileNumber(BuildContext context, String passwordController,
      String mobileNumberController) async {
    print('nnn mobile called');
    return await FirebaseFirestore.instance
        .collection("UserName")
        .where("MobileNumber", isEqualTo: mobileNumberController)
        .get();
  }
}
