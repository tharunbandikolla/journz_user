import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RightPane extends StatelessWidget {
  const RightPane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      width: context.percentWidth * 10,
      //color: Colors.white,
    );
  }
}
