import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageHeader extends StatefulWidget {
  final bool? wantSearchBar;
  const HomePageHeader({Key? key, this.wantSearchBar}) : super(key: key);

  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight * 0.085,
      color: Colors.grey.shade200,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: context.screenWidth * 0.015),
            width: context.screenWidth * 0.35,
            height: context.screenHeight * 0.085,
            child: Row(
              children: [
                Image.asset('assets/images/journzlogo1.png'),
                "JOURNZ".text.bold.xl2.makeCentered()
              ],
            ),
          ),
          widget.wantSearchBar!
              ? Container(
                  width: context.screenWidth * 0.3,
                  height: context.screenHeight * 0.045,
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.01),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(context.screenWidth * 0.05)),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Search..."),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
