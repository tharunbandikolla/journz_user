import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/Journz_Tab/tab_home_page_center_pane_article_card.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/Journz_Large_Screen/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class TabBodyCenterPaneArticleSection extends StatefulWidget {
  const TabBodyCenterPaneArticleSection({Key? key}) : super(key: key);

  @override
  _BodyCenterPaneArticleSectionState createState() =>
      _BodyCenterPaneArticleSectionState();
}

class _BodyCenterPaneArticleSectionState
    extends State<TabBodyCenterPaneArticleSection> {
  List<HiveArticleData> listOfArticles = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:
        BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
            builder: (context, userState) {
      return Container(
          padding: EdgeInsets.all(10),
          width: context.screenWidth * 0.9,
          height: context.screenHeight * 0.85,
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
                  } else if (currentSubtypename.selectedSubtype ==
                      "Favourites") {
                    if (userState.isLoggined!) {
                      value.values.forEach((element) {
                        if (userState.favCategories!.isNotEmpty) {
                          if (userState.favCategories!
                              .contains(element.articleSubtype)) {
                            listOfArticles.add(element);
                            print('Executed');
                          }
                        }
                      });
                    }
                  } else {
                    value.values.forEach((element) {
                      if (element.articleSubtype ==
                          currentSubtypename.selectedSubtype) {
                        listOfArticles.add(element);
                      }
                    });
                  }

                  return /* currentSubtypename.selectedSubtype == 'All'
                      ?  */
                      listOfArticles.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                    height: context.screenHeight * 0.035,
                                  ),
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listOfArticles.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    // ignore: unused_local_variable
                                    CodeArticleData data = CodeArticleData(
                                        articleDescription:
                                            listOfArticles[index]
                                                .articleDescription,
                                        articleLike:
                                            listOfArticles[index].articleLike,
                                        articlePhotoUrl: listOfArticles[index]
                                            .articlePhotoUrl,
                                        articleReportedBy: listOfArticles[index]
                                            .articleReportedBy,
                                        articleSubtype: listOfArticles[index]
                                            .articleSubtype,
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
                                        isArticlePublished:
                                            listOfArticles[index]
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
                                              "id": listOfArticles[index]
                                                  .documentId
                                            }),
                                        params: listOfArticles[index]);
                                  },
                                  child: Container(
                                    child: TabHomePageCenterPaneArticleCard(
                                        index: index,
                                        listOfArticles: listOfArticles),
                                  ),
                                );
                              })
                          : Center(
                              child: currentSubtypename.selectedSubtype ==
                                      "Favourites"
                                  ? Text("You Don\'t Have Any Favourite Articles Double Tap On Categories To Add Favourite Articles")
                                      .text
                                      .align(TextAlign.center)
                                      .make()
                                  : currentSubtypename.selectedSubtype == "All"
                                      ? Text("Getting Articles")
                                      : Text(
                                          "Selected Subtype Don\'t Have Any Favourite Articles"),
                            );
                  /*   : currentSubtypename.selectedSubtype == 'Favourites'
                          ? userState.favCategories!.isNotEmpty
                              ? ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: context.screenHeight * 0.035,
                                      ),
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listOfArticles.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        // ignore: unused_local_variable
                                        CodeArticleData data = CodeArticleData(
                                            articleDescription:
                                                listOfArticles[index]
                                                    .articleDescription,
                                            articleLike: listOfArticles[index]
                                                .articleLike,
                                            articlePhotoUrl: listOfArticles[index]
                                                .articlePhotoUrl,
                                            articleReportedBy: listOfArticles[index]
                                                .articleReportedBy,
                                            articleSubtype: listOfArticles[index]
                                                .articleSubtype,
                                            articleTitle: listOfArticles[index]
                                                .articleTitle,
                                            authorName: listOfArticles[index]
                                                .authorName,
                                            authorUid:
                                                listOfArticles[index].authorUid,
                                            bookmarkedBy: listOfArticles[index]
                                                .bookmarkedBy,
                                            country:
                                                listOfArticles[index].country,
                                            documentId: listOfArticles[index]
                                                .documentId,
                                            galleryImages: listOfArticles[index]
                                                .galleryImages,
                                            isArticlePublished:
                                                listOfArticles[index]
                                                    .isArticlePublished,
                                            isArticleReported:
                                                listOfArticles[index].isArticleReported,
                                            noOfComments: listOfArticles[index].noOfComments,
                                            noOfViews: listOfArticles[index].noOfViews,
                                            noOflikes: listOfArticles[index].noOflikes,
                                            socialMediaLink: listOfArticles[index].socialMediaLink);

                                        context.vxNav.push(
                                            Uri(
                                                path: MyRoutes.homeRoute,
                                                queryParameters: {
                                                  "Page": "/Articles",
                                                  "id": listOfArticles[index]
                                                      .documentId
                                                }),
                                            params: listOfArticles[index]);
                                      },
                                      child: Container(
                                        child: TabHomePageCenterPaneArticleCard(
                                            index: index,
                                            listOfArticles: listOfArticles),
                                      ),
                                    );
                                  })
                              : Center(
                                  child:
                                      "Double Tap on the categories to Add it in Favourite List"
                                          .text
                                          .semiBold
                                          .xl
                                          .make(),
                                )
                          : ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                    height: context.screenHeight * 0.035,
                                  ),
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listOfArticles.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    // ignore: unused_local_variable
                                    CodeArticleData data = CodeArticleData(
                                        articleDescription:
                                            listOfArticles[index]
                                                .articleDescription,
                                        articleLike:
                                            listOfArticles[index].articleLike,
                                        articlePhotoUrl: listOfArticles[index]
                                            .articlePhotoUrl,
                                        articleReportedBy: listOfArticles[index]
                                            .articleReportedBy,
                                        articleSubtype: listOfArticles[index]
                                            .articleSubtype,
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
                                        isArticlePublished:
                                            listOfArticles[index]
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
                                              "id": listOfArticles[index]
                                                  .documentId
                                            }),
                                        params: listOfArticles[index]);
                                  },
                                  child: Container(
                                    child: TabHomePageCenterPaneArticleCard(
                                        index: index,
                                        listOfArticles: listOfArticles),
                                  ),
                                );
                              });
                 */
                });
          }));
    }));
  }
}
