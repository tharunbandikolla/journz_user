import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class LeftPane extends StatelessWidget {
  const LeftPane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      width: context.percentWidth * 16,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
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
            child: const Icon(Icons.person),
          ),
          10.heightBox,
          //UserName
          "Guest User"
              .text
              .xl
              .textStyle(GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w700))
              .make(),
          //ViewProfile container
          InkWell(
            onTap: () {
              launch(
                  "https://play.google.com/store/apps/details?id=in.journz.journz");
            },
            child: Container(
              height: 40,
              width: context.screenWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: "Download Our App".text.lg.white.make(),
            ).p12(),
          ),
          50.heightBox,
        ],
      ).p12(),
    );
  }
}