import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:velocity_x/velocity_x.dart';

class LeftPaneBySai extends StatefulWidget {
  const LeftPaneBySai({Key? key}) : super(key: key);

  @override
  _LeftPaneBySaiState createState() => _LeftPaneBySaiState();
}

class _LeftPaneBySaiState extends State<LeftPaneBySai> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: context.screenHeight * 0.02,
            horizontal: context.screenWidth * 0.01),
        width: context.screenWidth * 0.175,
        // height: context.screenHeight,
        color: Colors.blue.shade50,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(5)),
              width: context.screenWidth,
              height: context.screenHeight * 0.5,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: context.screenHeight * 0.015,
                        left: context.screenWidth * 0.005,
                        right: context.screenWidth * 0.005),
                    /*  margin: EdgeInsets.symmetric(
                        vertical: context.screenHeight * 0.015,
                        horizontal: context.screenWidth * 0.005), */
                    width: context.screenWidth,
                    height: context.screenHeight * 0.125,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: context.screenWidth * 0.035,
                              height: context.screenHeight * 0.07,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                    'assets/images/logo.png',
                                  )),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(7.5)),
                            ),
                            SizedBox(width: context.screenWidth * 0.01),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Hello.".text.make(),
                                "Journz".text.xl.semiBold.make()
                              ],
                            )
                                .box
                                .width(context.screenWidth * 0.065)
                                .height(context.screenHeight * 0.07)
                                .make()
                          ],
                        ),
                        /*   Divider(
                          thickness: 1,
                          color: Colors.black38,
                        ), */
                      ],
                    ),
                  ),
                  Container(
                    width: context.screenWidth,
                    height: context.screenHeight * 0.37,
                    padding: EdgeInsets.only(
                        left: context.screenWidth * 0.005,
                        right: context.screenWidth * 0.005),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LeftPaneOptions(
                            icon: FontAwesomeIcons.brain, name: "Explore"),
                        LeftPaneOptions(
                            icon: FontAwesomeIcons.bookmark, name: 'Saved'),
                        LeftPaneOptions(icon: Icons.settings, name: 'Settings'),
                        LeftPaneOptions(
                            icon: FontAwesomeIcons.moon, name: 'Change Theme'),
                        LeftPaneOptions(icon: Icons.person, name: 'Profile'),
                        LeftPaneOptions(
                            icon: Icons.notifications, name: 'Notifications')
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LeftPaneOptions extends StatelessWidget {
  final IconData icon;
  final String name;
  const LeftPaneOptions({Key? key, required this.icon, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.black,
          ),
          SizedBox(width: context.screenWidth * 0.01),
          Text(name).text.xl.semiBold.make()
        ],
      ),
    );
  }
}
