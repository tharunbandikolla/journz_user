import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/Journz_Large_Screen/NewHomePage/Components/home_body_center_pane_article_section.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_body_center_pane_subtype_header.dart';
import '/Journz_Large_Screen/NewHomePage/Components/left_pane_profile.dart';

import 'package:velocity_x/velocity_x.dart';

import '../Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import 'home_page_body_right_pane.dart';

class BodyCenterPane extends StatefulWidget {
  /* final ShowCurrentlySelectedSubtypeCubit showCurrentSubtypeNameCubit; */
  final String? swapFavCatName;
  const BodyCenterPane({Key? key, required this.swapFavCatName
      /* required this.showCurrentSubtypeNameCubit */
      })
      : super(key: key);

  @override
  _BodyCenterPaneState createState() => _BodyCenterPaneState();
}

class _BodyCenterPaneState extends State<BodyCenterPane> {
  swapToFavouriteArticles(String screen) {
    context
        .read<ShowCurrentlySelectedSubtypeCubit>()
        .changeSelectedSubtypeTo(screen);
  }

  @override
  void didChangeDependencies() {
    if (widget.swapFavCatName != null) {
      context
          .read<ShowCurrentlySelectedSubtypeCubit>()
          .changeSelectedSubtypeTo(widget.swapFavCatName!);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      /*  padding: EdgeInsets.only(
        top: context.screenHeight * 0.0075,
        left: context.screenWidth * 0.005,
        right: context.screenWidth * 0.005,
      ), */
      duration: Duration(milliseconds: 300),
      width: context.screenWidth * 0.55,
      //height: context.screenHeight * 0.865,
      //color: Colors.grey.shade50,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //LeftPaneBySai(),

            LeftPaneProfile(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyCenterPaneSubtypeHeader(
                    /*  showCurrentSubtypeNameCubit:
                        widget.showCurrentSubtypeNameCubit */
                    ),
                SizedBox(height: context.screenHeight * 0.015),
                BodyCenterPaneArticleSection()
              ],
            ),
            BodyRightPane(
                isHome: true, favouriteCategory: swapToFavouriteArticles)
          ],
        ),
      ),
    );
  }
}
