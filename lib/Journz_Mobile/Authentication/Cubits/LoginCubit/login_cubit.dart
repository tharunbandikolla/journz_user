import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Component/LoginDatabase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  checkUserLogin(BuildContext context, String val, String password) {
    String? email;

    if (RegExp(r'[0-9]{10}$').hasMatch(val)) {
      LoginDatabase()
          .checkExistingMobileNumber(context, password, val)
          .then((value) {
        if (value.size != 0) {
          value.docs.forEach((element) async {
            email = await element.data()['Email'].toString();
          });

          Future.delayed(const Duration(milliseconds: 700), () async {
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email!, password: password)
                  .whenComplete(() async {
                FirebaseAuth.instance.currentUser?.reload();

                if (FirebaseAuth.instance.currentUser != null) {
                  context.vxNav.clearAndPush(Uri(path: "/"));
                }
              });
            } catch (e) {
              //  context.read<LoadingscreenCubit>().changeLoadingState(true);
              throw Exception(e);
            }
          });
        } else {
          //context.read<LoadingscreenCubit>().changeLoadingState(true);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Mobile Number Not Matching With Records')));
        }
      });
    } else if (RegExp(r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
            caseSensitive: false)
        .hasMatch(val)) {
      LoginDatabase().checkExistingEmail(context, password, val).then((value) {
        if (value.size != 0) {
          value.docs.forEach((element) async {
            print('nnn mobile num ${element.data()['Email']}');
            email = element.data()['Email'].toString();
          });

          Future.delayed(const Duration(milliseconds: 700), () async {
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email!, password: password)
                  .whenComplete(() async {
                FirebaseAuth.instance.currentUser?.reload();
                if (FirebaseAuth.instance.currentUser != null) {
                  context.vxNav.clearAndPush(Uri(path: "/"));
                }
              });
            } catch (e) {
              String msg = e
                  .toString()
                  .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(msg.trim()),
              ));
              //context.read<LoadingscreenCubit>().changeLoadingState(true);
              throw Exception(e);
            }
          });
        } else {
          //context.read<LoadingscreenCubit>().changeLoadingState(true);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email Not Matching With Records')));
        }
      });
    } else if (val.isNotEmpty) {
      LoginDatabase()
          .checkExistingUserName(context, password, val)
          .then((value) {
        if (value.size != 0) {
          value.docs.forEach((element) async {
            email = element.data()['Email'].toString();
          });

          Future.delayed(const Duration(milliseconds: 700), () async {
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email!, password: password)
                  .whenComplete(() async {
                FirebaseAuth.instance.currentUser?.reload();
                if (FirebaseAuth.instance.currentUser != null) {
                  context.vxNav.clearAndPush(Uri(path: "/"));
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
        } else {
          // context.read<LoadingscreenCubit>().changeLoadingState(true);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('UserName Not Matching With Records')));
        }
      });
    }
  }
}
