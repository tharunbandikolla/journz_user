import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../utils/routes.dart';

class CommonHomePageFooter extends StatefulWidget {
  const CommonHomePageFooter({Key? key}) : super(key: key);

  @override
  _CommonHomePageFooterState createState() => _CommonHomePageFooterState();
}

class _CommonHomePageFooterState extends State<CommonHomePageFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: EdgeInsets.symmetric(
          vertical: context.screenHeight * 0.025,
          horizontal: context.screenWidth * 0.075),
      color: Colors.black,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 100,
        runSpacing: 40,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "Follow Us".text.size(24).semiBold.white.make(),
              SizedBox(height: context.screenHeight * 0.01),
              Image.asset(
                'assets/images/socialMedia.png',
                width: 100,
              )
            ],
          ),
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
              SizedBox(height: context.screenHeight * 0.01),
              InkWell(
                  onTap: () {
                    context.vxNav.push(
                      Uri(
                          path: MyRoutes.homeRoute,
                          queryParameters: {"Page": "/ContactUs"}),
                    );
                  },
                  child: "Contact Us".text.xl.white.semiBold.make()),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Terms & Condition".text.xl.white.semiBold.make(),
              SizedBox(height: context.screenHeight * 0.01),
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