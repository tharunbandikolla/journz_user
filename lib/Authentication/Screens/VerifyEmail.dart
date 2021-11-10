import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journz_web/homePage/newhomepage.dart';
import 'package:journz_web/utils/routes.dart';
import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user;
  Timer? timer;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user!.emailVerified
          ? WidgetsBinding.instance!.addPostFrameCallback((_) {
              print('verified user');
              context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => HomePage(),
              //     ),
              //     (route) => false);
            })
          : user!.sendEmailVerification();
    }
    if (user != null) {
      if (user!.emailVerified == false) {
        timer = Timer.periodic(Duration(seconds: 15), (timer) async {
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
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomePage(),
        //     ),
        //     (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? WillPopScope(
            onWillPop: () async {
              print('nnn back button pressed');

              print('nnn b ece');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);

              return Future.value(true);
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('Verify Email'),
              ),
              body: Container(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset('images/verifyEmail.png'),
                    ),
                    SizedBox(
                      height: getWidth(context) * 0.07,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            'An Email Verification Link Sent To ${user!.email}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6)),
                    SizedBox(
                      height: getWidth(context) * 0.07,
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Please Verify Your Mail And come Back',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6))
                  ],
                ),
              ),
            ),
          )
        : Scaffold(body: Center(child: Text('hii')));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
