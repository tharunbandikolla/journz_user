import 'package:flutter/material.dart';
import 'package:journz_web/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageFooter extends StatefulWidget {
  const HomePageFooter({Key? key}) : super(key: key);

  @override
  _HomePageFooterState createState() => _HomePageFooterState();
}

class _HomePageFooterState extends State<HomePageFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight * 0.05,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                context.vxNav.push(Uri(
                    path: MyRoutes.homeRoute,
                    queryParameters: {"Page": "/Marketing"}));
              },
              child: Text('Marketing',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
          SizedBox(width: context.screenWidth * 0.05),
          TextButton(
              onPressed: () {
                context.vxNav.push(Uri(
                    path: MyRoutes.homeRoute,
                    queryParameters: {"Page": "/PrivacyPolicy"}));
              },
              child: Text('Privacy Policy',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
          SizedBox(width: context.screenWidth * 0.05),
          TextButton(
              onPressed: () {
                context.vxNav.push(Uri(
                    path: MyRoutes.homeRoute,
                    queryParameters: {"Page": "/ContactUs"}));
              },
              child: Text('Contact Us',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
          SizedBox(width: context.screenWidth * 0.05),
          Text('All Rights Reservered To AAMTSPN PVT LTD \u00a9 2021',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
