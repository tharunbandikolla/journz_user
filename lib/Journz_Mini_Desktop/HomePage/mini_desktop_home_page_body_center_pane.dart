import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Journz_Large_Screen/NewHomePage/Components/left_pane_profile.dart';
import 'mini_desktop_home_body_center_pane_article_section.dart';
import 'mini_desktop_home_page_body_center_pane_subtype_header.dart';

class MiniDeskBodyCenterPane extends StatefulWidget {
  /* final ShowCurrentlySelectedSubtypeCubit showCurrentSubtypeNameCubit; */
  const MiniDeskBodyCenterPane({
    Key? key,
    /* required this.showCurrentSubtypeNameCubit */
  }) : super(key: key);

  @override
  _BodyCenterPaneState createState() => _BodyCenterPaneState();
}

class _BodyCenterPaneState extends State<MiniDeskBodyCenterPane> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      /*  padding: EdgeInsets.only(
        top: context.screenHeight * 0.0075,
        left: context.screenWidth * 0.005,
        right: context.screenWidth * 0.005,
      ), */
      duration: Duration(milliseconds: 300),
      // width: context.screenWidth * 0.55,
      //height: context.screenHeight * 0.865,
      //color: Colors.grey.shade50,
      child: SingleChildScrollView(
        child: Column(
          children: [
            MiniDeskBodyCenterPaneSubtypeHeader(
                /*  showCurrentSubtypeNameCubit:
                            widget.showCurrentSubtypeNameCubit */
                ),
            SizedBox(height: context.screenHeight * 0.05),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //LeftPaneBySai(),

                LeftPaneProfile(),
                SizedBox(width: context.screenWidth * 0.05),

                MiniDeskBodyCenterPaneArticleSection()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
