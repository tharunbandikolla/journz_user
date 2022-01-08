import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'package:journz_web/HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import 'package:journz_web/NewHomePage/Components/home_page_center_pane_article_card.dart';

import 'package:journz_web/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import 'package:journz_web/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journz_web/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class BodyCenterPaneArticleSection extends StatefulWidget {
  const BodyCenterPaneArticleSection({Key? key}) : super(key: key);

  @override
  _BodyCenterPaneArticleSectionState createState() =>
      _BodyCenterPaneArticleSectionState();
}

class _BodyCenterPaneArticleSectionState
    extends State<BodyCenterPaneArticleSection> {
  List<HiveArticleData> listOfArticles = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.screenWidth * 0.015,
        right:
            context.screenWidth * 0.015, /* top: context.screenHeight * 0.015 */
      ),
      width: context.screenWidth * 0.6,
      height: context.screenHeight * 0.7,
      child: BlocBuilder<ShowCurrentlySelectedSubtypeCubit,
          ShowCurrentlySelectedSubtypeState>(
        builder: (context, currentSubtypename) {
          return ValueListenableBuilder<Box<HiveArticleData>>(
              valueListenable: Boxes.getArticleFromCloud().listenable(),
              builder: (context, value, _) {
                listOfArticles = [];
                if (currentSubtypename.selectedSubtype == "All") {
                  listOfArticles =
                      value.values.toList().cast<HiveArticleData>();
                } else {
                  value.values.forEach((element) {
                    if (element.articleSubtype ==
                        currentSubtypename.selectedSubtype) {
                      listOfArticles.add(element);
                    }
                  });
                }

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listOfArticles.length,
                  /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4.5,
                      // mainAxisSpacing: context.screenHeight * 0.015,
                      // crossAxisSpacing: context.screenHeight * 0.015,
                      crossAxisCount: 1), */
                  itemBuilder: (context, index) {
                    return currentSubtypename.selectedSubtype! == 'All'
                        ? InkWell(
                            onTap: () async {
                              // ignore: unused_local_variable
                              CodeArticleData data = CodeArticleData(
                                  articleDescription:
                                      listOfArticles[index].articleDescription,
                                  articleLike:
                                      listOfArticles[index].articleLike,
                                  articlePhotoUrl:
                                      listOfArticles[index].articlePhotoUrl,
                                  articleReportedBy:
                                      listOfArticles[index].articleReportedBy,
                                  articleSubtype:
                                      listOfArticles[index].articleSubtype,
                                  articleTitle:
                                      listOfArticles[index].articleTitle,
                                  authorName: listOfArticles[index].authorName,
                                  authorUid: listOfArticles[index].authorUid,
                                  bookmarkedBy:
                                      listOfArticles[index].bookmarkedBy,
                                  country: listOfArticles[index].country,
                                  documentId: listOfArticles[index].documentId,
                                  galleryImages:
                                      listOfArticles[index].galleryImages,
                                  isArticlePublished:
                                      listOfArticles[index].isArticlePublished,
                                  isArticleReported:
                                      listOfArticles[index].isArticleReported,
                                  noOfComments:
                                      listOfArticles[index].noOfComments,
                                  noOfViews: listOfArticles[index].noOfViews,
                                  noOflikes: listOfArticles[index].noOflikes,
                                  socialMediaLink:
                                      listOfArticles[index].socialMediaLink);

                              context.vxNav.push(
                                  Uri(
                                      path: MyRoutes.homeRoute,
                                      queryParameters: {
                                        "Page": "/Articles",
                                        "id": listOfArticles[index].documentId
                                      }),
                                  params: listOfArticles[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: index.isOdd
                                      ? context.screenWidth * 0.1
                                      : 0,
                                  right: index.isEven
                                      ? context.screenWidth * 0.1
                                      : 0),
                              child: HomePageCenterPaneArticleCard(
                                  index: index, listOfArticles: listOfArticles),
                            ),
                          )
                        : currentSubtypename.selectedSubtype ==
                                listOfArticles[index].articleSubtype
                            ? InkWell(
                                onTap: () async {
                                  // ignore: unused_local_variable
                                  CodeArticleData data = CodeArticleData(
                                      articleDescription: listOfArticles[index]
                                          .articleDescription,
                                      articleLike:
                                          listOfArticles[index].articleLike,
                                      articlePhotoUrl:
                                          listOfArticles[index].articlePhotoUrl,
                                      articleReportedBy: listOfArticles[index]
                                          .articleReportedBy,
                                      articleSubtype:
                                          listOfArticles[index].articleSubtype,
                                      articleTitle:
                                          listOfArticles[index].articleTitle,
                                      authorName:
                                          listOfArticles[index].authorName,
                                      authorUid:
                                          listOfArticles[index].authorUid,
                                      bookmarkedBy:
                                          listOfArticles[index].bookmarkedBy,
                                      country: listOfArticles[index].country,
                                      documentId:
                                          listOfArticles[index].documentId,
                                      galleryImages:
                                          listOfArticles[index].galleryImages,
                                      isArticlePublished: listOfArticles[index]
                                          .isArticlePublished,
                                      isArticleReported: listOfArticles[index]
                                          .isArticleReported,
                                      noOfComments:
                                          listOfArticles[index].noOfComments,
                                      noOfViews:
                                          listOfArticles[index].noOfViews,
                                      noOflikes:
                                          listOfArticles[index].noOflikes,
                                      socialMediaLink: listOfArticles[index]
                                          .socialMediaLink);

                                  context.vxNav.push(
                                      Uri(
                                          path: MyRoutes.homeRoute,
                                          queryParameters: {
                                            "Page": "/Articles",
                                            "id":
                                                listOfArticles[index].documentId
                                          }),
                                      params: listOfArticles[index]);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: index.isOdd
                                          ? context.screenWidth * 0.1
                                          : 0,
                                      right: index.isEven
                                          ? context.screenWidth * 0.1
                                          : 0),
                                  child: HomePageCenterPaneArticleCard(
                                      index: index,
                                      listOfArticles: listOfArticles),
                                ),
                              )
                            : Container();
                  },
                );
              });
        },
      ),
    );
  }
}
