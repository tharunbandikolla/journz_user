import 'package:flutter/material.dart';
import '/Journz_Large_Screen/utils/routes.dart';
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
      padding: EdgeInsets.symmetric(
          vertical: context.screenHeight * 0.025,
          horizontal: context.screenWidth * 0.075),
      height: context.screenHeight * 0.225,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Follow Us".text.xl.semiBold.white.make(),
              SizedBox(height: context.screenHeight * 0.03),
              Image.asset('assets/images/socialMedia.png')
                  .box
                  .width(context.screenWidth * 0.05)
                  .height(context.screenHeight * 0.1)
                  .make()
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