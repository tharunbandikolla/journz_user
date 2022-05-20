import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../Journz_Large_Screen/utils/routes.dart';

class MobileSignupSuccess extends StatefulWidget {
  const MobileSignupSuccess({Key? key}) : super(key: key);

  @override
  State<MobileSignupSuccess> createState() => _MobileSignupSuccessState();
}

class _MobileSignupSuccessState extends State<MobileSignupSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/starsBG.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            "You Have Successfully Created Your Account"
                .text
                .bold
                .xl4
                .white
                .align(TextAlign.center)
                .make()
                .box
                .p16
                .alignCenter
                .make(),
            "Please Check Your Registered Email To Verify Your Account"
                .text
                .lg
                .white
                .align(TextAlign.center)
                .make()
                .box
                .p16
                .alignCenter
                .make(),
            SizedBox(height: 150),
            ElevatedButton(
                onPressed: () {
                  context.vxNav.popToRoot();
                },
                child: Text("Return Home"))
          ],
        ),
      ),
    );
  }
}
