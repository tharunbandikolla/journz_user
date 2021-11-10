import 'dart:async';

import 'package:flutter/material.dart';
import 'package:journz_web/constants/sharedprefrence_services/shared_prefrence_service.dart';
import 'package:journz_web/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PrefService _prefService = PrefService();

  @override
  void initState() {
    _prefService.readCache("email").then((value) {
      print(value.toString());
      if (value != null) {
        return Timer(Duration(seconds: 2),
            () => context.vxNav.push(Uri.parse(MyRoutes.homeRoute)));
      } else {
        return Timer(Duration(seconds: 2),
            () => context.vxNav.push(Uri.parse(MyRoutes.homeRoute)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            "Welcome to Journz".text.white.xl4.make(),
            5.heightBox,
            Image.asset("assets/images/journzpng2.png"),
          ],
        ),
      ),
    );
  }
}
