import 'package:flutter/material.dart';

import 'package:journz_web/NewHomePage/Components/home_body_center_pane_article_section.dart';
import 'package:journz_web/NewHomePage/Components/home_page_body_center_pane_subtype_header.dart';

import '/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class BodyCenterPane extends StatefulWidget {
  final ShowCurrentlySelectedSubtypeCubit showCurrentSubtypeNameCubit;
  const BodyCenterPane({Key? key, required this.showCurrentSubtypeNameCubit})
      : super(key: key);

  @override
  _BodyCenterPaneState createState() => _BodyCenterPaneState();
}

class _BodyCenterPaneState extends State<BodyCenterPane> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(
        top: context.screenHeight * 0.025,
        left: context.screenWidth * 0.005,
        right: context.screenWidth * 0.005,
      ),
      duration: Duration(milliseconds: 300),
      width: context.screenWidth * 0.6,
      height: context.screenHeight * 0.865,
      //color: Colors.grey.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BodyCenterPaneSubtypeHeader(
              showCurrentSubtypeNameCubit: widget.showCurrentSubtypeNameCubit),
          //SizedBox(height: context.screenHeight * 0.4),
          BodyCenterPaneArticleSection()
        ],
      ),
    );
  }
}
