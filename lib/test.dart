import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            "Width Based Widget"
                .text
                .xl
                .make()
                .box
                .margin(EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.05,
                    vertical: context.screenWidth * 0.025))
                .width(context.screenWidth * 0.2)
                .height(context.screenWidth * 0.1)
                .amber100
                .make(),
            "No Width Based Widget"
                .text
                .xl
                .make()
                .box
                .margin(EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.05,
                    vertical: context.screenHeight * 0.05))
                .width(context.screenWidth * 0.2)
                .height(context.screenHeight * 0.1)
                .amber100
                .make()
          ],
        ),
      ),
    );
  }
}
