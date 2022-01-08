import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class BodyRightPane extends StatefulWidget {
  const BodyRightPane({Key? key}) : super(key: key);

  @override
  _BodyRightPaneState createState() => _BodyRightPaneState();
}

class _BodyRightPaneState extends State<BodyRightPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.screenHeight * 0.02),
      width: context.screenWidth * 0.15,
      height: context.screenHeight * 0.865,
      //color: Colors.grey.shade50,
    );
  }
}
