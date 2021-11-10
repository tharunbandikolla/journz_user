import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journz_web/constants/sharedprefrence_services/shared_prefrence_service.dart';
import 'package:journz_web/homePage/newhomepage.dart';
import 'package:journz_web/utils/routes.dart';
import '/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import '/Authentication/DataServices/LoginDatabase.dart';
import '/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  PrefService _prefService = PrefService();

  LoginCubit() : super(LoginInitial());

  checkUserLogin(BuildContext context, String val, String password) {
    String? email;

    print('nnn val $val   password $password');
    if (RegExp(r'[0-9]{10}$').hasMatch(val)) {
      LoginDatabase()
          .checkExistingMobileNumber(context, password, val)
          .then((value) {
        if (value.size != 0) {
          value.docs.forEach((element) async {
            print('nnn mobile num ${element.data()['Email']}');
            email = await element.data()['Email'].toString();
          });

          Future.delayed(Duration(milliseconds: 700), () async {
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email!, password: password)
                  .whenComplete(() async {
                FirebaseAuth.instance.currentUser?.reload();
                if (FirebaseAuth.instance.currentUser != null) {
                  print(' nnn passing through this way');
                  _prefService.createCache(val).whenComplete(() {
                    if (val.isNotEmpty && password.isNotEmpty) {
                      context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
                    }
                  });

                  //context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MultiBlocProvider(providers: [
                  //             BlocProvider(
                  //                 create: (context) => ShowhidepasswordCubit()),
                  //           ], child: HomePage())),
                  //   //(route) => false
                  // );
                }
              });
            } catch (e) {
              //String msg = e
              //  .toString()
              //  .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
              //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text(msg.trim()),
              //  ));
              context.read<LoadingscreenCubit>().changeLoadingState(true);
              throw Exception(e);
            }
          });
        } else {
          context.read<LoadingscreenCubit>().changeLoadingState(true);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

          Future.delayed(Duration(milliseconds: 700), () async {
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email!, password: password)
                  .whenComplete(() async {
                FirebaseAuth.instance.currentUser?.reload();
                if (FirebaseAuth.instance.currentUser != null) {
                  _prefService.createCache(val).whenComplete(() {
                    if (val.isNotEmpty && password.isNotEmpty) {
                      context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
                    }
                  });
                  //context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MultiBlocProvider(providers: [
                  //             BlocProvider(
                  //                 create: (context) => ShowhidepasswordCubit()),
                  //           ], child: HomePage())),
                  //   //(route) => false
                  // );
                }
              });
            } catch (e) {
              String msg = e
                  .toString()
                  .replaceFirst(RegExp(r'\[(.*?)\]', caseSensitive: false), '');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(msg.trim()),
              ));
              context.read<LoadingscreenCubit>().changeLoadingState(true);
              throw Exception(e);
            }
          });
        } else {
          context.read<LoadingscreenCubit>().changeLoadingState(true);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Email Not Matching With Records')));
        }
      });
    } else if (val.isNotEmpty) {
      LoginDatabase()
          .checkExistingUserName(context, password, val)
          .then((value) {
        if (value.size != 0) {
          value.docs.forEach((element) async {
            print('nnn mobile num ${element.data()['Email']}');
            email = element.data()['Email'].toString();
          });

          Future.delayed(Duration(milliseconds: 700), () async {
            try {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email!, password: password)
                  .whenComplete(() async {
                FirebaseAuth.instance.currentUser?.reload();
                if (FirebaseAuth.instance.currentUser != null) {
                  _prefService.createCache(val).whenComplete(() {
                    if (val.isNotEmpty && password.isNotEmpty) {
                      context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
                    }
                  });
                  //context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MultiBlocProvider(providers: [
                  //             BlocProvider(
                  //                 create: (context) => ShowhidepasswordCubit()),
                  //           ], child: HomePage())),
                  //   //(route) => false
                  // );
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
          context.read<LoadingscreenCubit>().changeLoadingState(true);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('UserName Not Matching With Records')));
        }
      });
    }
  }
}
