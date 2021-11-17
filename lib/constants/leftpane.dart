//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:journz_web/Authentication/AuthenticationBloc/LoginCubit/login_cubit.dart';
import 'package:journz_web/Authentication/AuthenticationBloc/LoginScreenPasswordBloc/showhidepassword_cubit.dart';
import 'package:journz_web/Authentication/DataServices/LoginDatabase.dart';
import 'package:journz_web/Authentication/Screens/ForgotPasswordScreen.dart';
import 'package:journz_web/Common/Helper/LoadingScreenCubit/loadingscreen_cubit.dart';
import 'package:journz_web/Common/Widgets/NewCircularElevattedButton.dart';
import 'package:journz_web/Common/Widgets/NewTextFormField.dart';
import 'package:journz_web/constants/sharedprefrence_services/shared_prefrence_service.dart';
import 'package:journz_web/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class LeftPane extends StatefulWidget {
  const LeftPane({
    Key? key,
  }) : super(key: key);

  @override
  State<LeftPane> createState() => _LeftPaneState();
}

class _LeftPaneState extends State<LeftPane> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  //final PrefService _prefService = PrefService();
  late String role;
  late String username;
  late String photourl;
  late List<dynamic> fav;

  PrefService _prefService = PrefService();

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
                      setState(() {});
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
                      setState(() {});
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
                      setState(() {});
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

  // loginFunc() {
  //   if (_loginFormKey.currentState!.validate()) {
  //     _loginFormKey.currentState!.save();
  //     context.read<LoadingscreenCubit>().changeLoadingState(false);
  //     context.read<LoginCubit>().checkUserLogin(
  //         context, userNameController.text, passwordController.text);
  //   }
  // }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('UserProfile')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        username = ds.data()!['UserName'];
        photourl = ds.data()!['PhotoUrl'];
        role = ds.data()!['Role'];
        fav = ds.data()!['UsersFavouriteArticleCategory'];
        print(fav);
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginPassWordVisibilityCubit =
        BlocProvider.of<ShowhidepasswordCubit>(context);
    return Container(
      height: context.screenHeight,
      width: context.percentWidth * 16,
      //color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    offset: Offset(4, 4),
                    spreadRadius: 1,
                    blurRadius: 15,
                    color: Colors.black26),
                BoxShadow(
                    offset: Offset(-4, -4),
                    spreadRadius: 1,
                    blurRadius: 15,
                    color: Colors.white)
              ],
            ),
            child: FirebaseAuth.instance.currentUser == null
                ? notLoggedIn(context, loginPassWordVisibilityCubit)
                : FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return LoggedIn(
                        photourl: photourl,
                        username: username,
                        fav: fav,
                        role: role,
                      ).p12();
                    }),
          ).p12(),
        ],
      ),
    );
  }

  Column notLoggedIn(BuildContext context,
      ShowhidepasswordCubit loginPassWordVisibilityCubit) {
    return Column(
      children: [
        10.heightBox,
        Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NewTextFormField(
                  readOnly: false,
                  keyBoardType: TextInputType.name,
                  newWidth: context.screenWidth,
                  //newHeight: 50,
                  hintText: 'UserName \\ Email \\ Mobile Number',
                  controller: userNameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Email/UserName/Mobile Number';
                    }
                  }),
              20.heightBox,
              BlocBuilder<ShowhidepasswordCubit, ShowHidePasswordState>(
                builder: (context, passwordState) {
                  return TextFormField(
                    controller: passwordController,
                    obscureText: passwordState.showHidePassWord,
                    onFieldSubmitted: (String v) {
                      //loginFunc();
                      checkUserLogin(context, userNameController.text,
                          passwordController.text);
                    },
                    validator: (val) {
                      if (!RegExp(
                              r'(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#$%^&*_-])[A-Za-z0-9~!?@#$%^&*_-]{6,40}$')
                          .hasMatch(val!)) {
                        return 'Password length > 5, Must Contain [a-z] [0-9] [@#]';
                      }
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: Colors.transparent,
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (passwordState.showHidePassWord) {
                                loginPassWordVisibilityCubit
                                    .updateShowHidePasswordBool(false);
                              } else {
                                loginPassWordVisibilityCubit
                                    .updateShowHidePasswordBool(true);
                              }
                            },
                            icon: passwordState.showHidePassWord
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black)),
                  );
                },
              ),
              InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()));
                      },
                      child: "Forgot Password?".text.black.bold.lg.make())
                  .box
                  .alignCenterRight
                  .width(150)
                  .height(40)
                  .makeCentered(),
              20.heightBox,
              NewCircularElevattedButton(
                name: "Login",
                func: () {
                  checkUserLogin(context, userNameController.text,
                      passwordController.text);
                },
                padHorizontal: 40,
                padVertical: 20,
                fontSize: 15,
              ),
              20.heightBox,
            ],
          ).p12(),
        ),
        //50.heightBox,
      ],
    );
  }
}

class LoggedIn extends StatelessWidget {
  final PrefService _prefService = PrefService();
  late String role;
  String username;
  String photourl;
  List<dynamic> fav;

  LoggedIn({
    Key? key,
    required this.role,
    required this.username,
    required this.photourl,
    required this.fav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: photourl == "images/fluenzologo.png"
                    ? AssetImage(photourl)
                    : NetworkImage(photourl) as ImageProvider),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(4, 4),
                  spreadRadius: 1,
                  blurRadius: 15,
                  color: Colors.black26),
              BoxShadow(
                  offset: Offset(-4, -4),
                  spreadRadius: 1,
                  blurRadius: 15,
                  color: Colors.white)
            ],
          ),
          //child: Image.asset(photourl),
        ),
        10.heightBox,
        //UserName
        "${username}"
            .text
            .xl
            .textStyle(
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700))
            .make(),
        //ViewProfile container
        InkWell(
          onTap: () async {
            await FirebaseAuth.instance.signOut().whenComplete(
                () => context.vxNav.push(Uri.parse(MyRoutes.homeRoute)));
            // await _prefService.removeCache("password").whenComplete(() {
            //   context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
            // });
          },
          // launch(
          //     "https://play.google.com/store/apps/details?id=in.journz.journz");
          //},
          child: Container(
            height: 40,
            width: context.screenWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: "Sign Out".text.lg.white.make(),
          ).p12(),
        ),
        50.heightBox,
      ],
    );
  }

  // _fetch() async {
  //   final firebaseUser = FirebaseAuth.instance.currentUser;
  //   if (firebaseUser != null) {
  //     await FirebaseFirestore.instance
  //         .collection('UserProfile')
  //         .doc(firebaseUser.uid)
  //         .get()
  //         .then((ds) {
  //       username = ds.data()!['UserName'];
  //       photourl = ds.data()!['PhotoUrl'];
  //       role = ds.data()!['Role'];
  //       fav = ds.data()!['UsersFavouriteArticleCategory'];
  //       print(fav);
  //     }).catchError((e) {
  //       print(e);
  //     });
  //   }
  // }
}
