import 'package:flutter/material.dart';
import '/Journz_Tab/tab_home_body_center_pane_article_section.dart';
import '/Journz_Tab/tab_home_page_body_center_pane_article_subtype_header.dart';
import 'package:velocity_x/velocity_x.dart';

class TabBodyCenterPane extends StatefulWidget {
  /* final ShowCurrentlySelectedSubtypeCubit showCurrentSubtypeNameCubit; */
  const TabBodyCenterPane({
    Key? key,
    /* required this.showCurrentSubtypeNameCubit */
  }) : super(key: key);

  @override
  _BodyCenterPaneState createState() => _BodyCenterPaneState();
}

class _BodyCenterPaneState extends State<TabBodyCenterPane> {
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
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TabBodyCenterPaneSubtypeHeader(
                      /*  showCurrentSubtypeNameCubit:
                          widget.showCurrentSubtypeNameCubit */
                      ),
                  SizedBox(height: context.screenHeight * 0.05),
                  TabBodyCenterPaneArticleSection()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
