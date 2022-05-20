import 'package:flutter_html/flutter_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journz_web/Journz_Large_Screen/NewHomePage/Components/footer.dart';
import 'package:journz_web/Journz_Mobile/HomePage/mobile_home_page_article_card.dart';

import '../../Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '../../Journz_Large_Screen/utils/routes.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_body_right_pane.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_footer.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_header.dart';
import '/Journz_Large_Screen/NewHomePage/Components/left_pane_profile.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:velocity_x/velocity_x.dart';

class MobileShowRejectedArticles extends StatefulWidget {
  const MobileShowRejectedArticles({Key? key}) : super(key: key);

  @override
  _MobileShowRejectedArticlesState createState() =>
      _MobileShowRejectedArticlesState();
}

class _MobileShowRejectedArticlesState
    extends State<MobileShowRejectedArticles> {
  List<HiveArticleData> personalArticles = [];
  @override
  Widget build(BuildContext context) {
    final userState = BlocProvider.of<CheckuserloginedCubit>(context);
    userState.checkLogin();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomePageHeader(wantSearchBar: false, fromMobile: true),
          SizedBox(height: context.screenWidth * 0.015),
          Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.3), width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 8,
                      child: "Rejected Articles"
                          .text
                          .xl2
                          .bold
                          .make()
                          .box
                          .alignCenterLeft
                          .px20
                          .width(context.screenWidth * 0.8)
                          .height(context.screenWidth * 0.15)
                          .make(),
                    ),
                    SizedBox(height: context.screenWidth * 0.03),
                    BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                      builder: (context, loginState) {
                        return loginState.isLoggined!
                            ? Container(
                                child: ValueListenableBuilder<
                                        Box<HiveArticleData>>(
                                    valueListenable: Boxes.getArticleFromCloud()
                                        .listenable(),
                                    builder: (context, value, _) {
                                      value.values.forEach((element) {
                                        if (element.authorUid ==
                                                loginState.userUid &&
                                            element.isArticlePublished ==
                                                "Rejected") {
                                          personalArticles.add(element);
                                        }
                                      });
                                      return personalArticles.isNotEmpty
                                          ? ListView.separated(
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 20),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  personalArticles.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                    onTap: () {
                                                      context.vxNav.push(
                                                          Uri(
                                                              path: MyRoutes
                                                                  .homeRoute,
                                                              queryParameters: {
                                                                "Page":
                                                                    "/Articles",
                                                                "id": personalArticles[
                                                                        index]
                                                                    .documentId
                                                              }),
                                                          params:
                                                              personalArticles[
                                                                  index]);
                                                    },
                                                    child: MobileArticleCard(
                                                      index: index,
                                                      listOfArticles:
                                                          personalArticles,
                                                    )) /*) */;
                                                ;
                                              },
                                            )
                                              .box
                                              .width(context.screenWidth)
                                              .height(
                                                  context.screenWidth * 1.25)
                                              .make()
                                          : Center(
                                              child: Text(
                                                  "You Dont Have Articles"),
                                            )
                                              .box
                                              .width(context.screenWidth * 0.55)
                                              .height(
                                                  context.screenWidth * 1.25)
                                              .make();
                                    }),
                              )
                            : Center(
                                child: Text('Please Login Into Your Account'),
                              );
                      },
                    )
                  ],
                ),
              ),
              CommonHomePageFooter()
            ],
          )
              .scrollVertical()
              .box
              .width(context.screenWidth)
              .height(context.screenWidth * 1.6)
              .make()
        ],
      ).scrollVertical(),
    );
  }

  swapToFavouriteArticles(String screen) {
    context
        .read<ShowCurrentlySelectedSubtypeCubit>()
        .changeSelectedSubtypeTo(screen);
  }
}
