import 'package:flutter/material.dart';
import 'package:universal_html/js.dart';
import 'package:velocity_x/velocity_x.dart';

class Left extends StatelessWidget {
  const Left({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          85.heightBox,
          Container(
            height: 130,
            width: 170,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile1.jpg"),
                ),
                5.heightBox,
                "Dhruvil Gosalia".text.black.bold.lg.make()
              ],
            ).p24(),
          ),
          25.heightBox,
          Container(
            height: 400,
            width: 170,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
          )
        ],
      ).pOnly(left: 30, right: 15),
    );
  }
}
