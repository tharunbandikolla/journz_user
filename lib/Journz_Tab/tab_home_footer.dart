import 'package:flutter/material.dart';
import '/Journz_Large_Screen/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class TabHomePageFooter extends StatefulWidget {
  const TabHomePageFooter({Key? key}) : super(key: key);

  @override
  _TabHomePageFooterState createState() => _TabHomePageFooterState();
}

class _TabHomePageFooterState extends State<TabHomePageFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      /*  padding: EdgeInsets.symmetric(
          vertical: context.screenWidth * 0.005,
          horizontal: context.screenWidth * 0.055), */
      height: context.screenWidth * 0.25,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: context.screenWidth * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Follow Us".text.xl.semiBold.white.make(),
                  SizedBox(height: context.screenWidth * 0.005),
                  Image.asset('assets/images/socialMedia.png')
                      .box
                      .width(context.screenWidth * 0.1)
                      .height(context.screenWidth * 0.1)
                      .make()
                ],
              ),
              SizedBox(width: context.screenWidth * 0.15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/Marketing"}),
                        );
                      },
                      child: "Marketing".text.xl.white.semiBold.make()),
                  InkWell(
                      onTap: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/ContactUs"}),
                        );
                      },
                      child: "Contact Us".text.xl.white.semiBold.make()),
                  "Terms & Condition".text.xl.white.semiBold.make(),
                  InkWell(
                      onTap: () {
                        context.vxNav.push(
                          Uri(
                              path: MyRoutes.homeRoute,
                              queryParameters: {"Page": "/PrivacyPolicy"}),
                        );
                      },
                      child: "Privacy Policy".text.xl.white.semiBold.make()),
                ],
              ),
            ],
          ),
          SizedBox(height: context.screenWidth * 0.015),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'All Rights Reservered To AAMTSPN PVT LTD \u00a9 2021'
                  .text
                  .xl
                  .white
                  .semiBold
                  .make()
            ],
          )
        ],
      ),
    );
  }
}

/* Row(
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
      ) */
