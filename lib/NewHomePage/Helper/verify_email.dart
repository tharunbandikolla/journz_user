import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user;
  Timer? timer;

  var currentBackPressTime;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user!.emailVerified
          ? WidgetsBinding.instance!.addPostFrameCallback((_) {})
          : user!.sendEmailVerification();
    }
    if (user != null) {
      if (user!.emailVerified == false) {
        timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
          await checkEmailVerification();
        });
      }
    }
    super.initState();
  }

  Future<void> checkEmailVerification() async {
    user = _auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      WidgetsBinding.instance!.addPostFrameCallback((_) {});
    }

    @override
    Widget build(BuildContext context) {
      return user != null
          ? /* WillPopScope(
            onWillPop: () async {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(curIndex: 0)),
                  (route) => false);

              return Future.value(true);
            },
            child: */
          WillPopScope(
              onWillPop: () {
                /*  DateTime now = DateTime.now();
              if (currentBackPressTime == null ||
                  now.difference(currentBackPressTime ?? now) >
                      const Duration(seconds: 2)) {
                currentBackPressTime = now;
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text('Hey Go Now But Come Back Soon..'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close')),
                            TextButton(
                                onPressed: () {
                                  if (Platform.isAndroid) {
                                    if (FirebaseAuth.instance.currentUser !=
                                        null) {
                                      if (FirebaseAuth
                                          .instance.currentUser!.isAnonymous) {
                                        FirebaseAuth.instance.currentUser!
                                            .delete()
                                            .then((value) {
                                          //    StartupThemePreferences.setShown(
                                          //      pref, false);
                                          SystemNavigator.pop();
                                        });
                                      } else {
                                        // StartupThemePreferences.setShown(pref, false);
                                        SystemNavigator.pop();
                                      }
                                    } else {
                                      //StartupThemePreferences.setShown(pref, false);
                                      SystemNavigator.pop();
                                    }
                                  } else if (Platform.isIOS) {
                                    //StartupThemePreferences.setShown(pref, false);
                                    exit(0);
                                  }
              */ /*                  },
                                child: const Text('Okay'))
                          ]);
                    });

                return Future.value(false);
              } */

                return Future.value(true);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Verify Email'),
                ),
                body: SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        child: Image.asset('assets/images/verifyEmail.png'),
                      ),
                      SizedBox(
                        height: context.screenHeight * 0.07,
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                              'An Email Verification Link Sent To ${user!.email}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6)),
                      SizedBox(
                        height: context.screenHeight * 0.07,
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: Text('Please Verify Your Mail And come Back',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6)),
                    ],
                  ),
                ),
              ),
            )
          : const Scaffold(body: Center(child: Text('Loading....')));
    }

    @override
    void dispose() {
      timer?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
