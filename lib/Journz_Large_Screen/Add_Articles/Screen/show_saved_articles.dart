import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import '/Journz_Large_Screen/Add_Articles/cubits/get_saved_articles_cubit/get_bookmarked_articles_cubit.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_body_right_pane.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_footer.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_header.dart';
import '/Journz_Large_Screen/NewHomePage/Components/left_pane_profile.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import '../../NewHomePage/Components/home_page_center_pane_article_card.dart';
import '../../NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '../../utils/routes.dart';

class ShowSavedArticles extends StatefulWidget {
  const ShowSavedArticles({Key? key}) : super(key: key);

  @override
  _ShowSavedArticlesState createState() => _ShowSavedArticlesState();
}

class _ShowSavedArticlesState extends State<ShowSavedArticles> {
  List<HiveArticleData> listOfArticles = [];
  @override
  Widget build(BuildContext context) {
    final userState = BlocProvider.of<CheckuserloginedCubit>(context);
    userState.checkLogin();
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageHeader(wantSearchBar: true, fromMobile: false),
            SizedBox(height: context.screenHeight * 0.015),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeftPaneProfile(),
                    Container(
                      //  color: Colors.red,
                      width: context.screenWidth * 0.55,
                      height: context.screenHeight * 0.9,
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black.withOpacity(0.3),
                                  width: 2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 8,
                            child: "Saved Articles"
                                .text
                                .xl2
                                .bold
                                .make()
                                .box
                                .alignCenterLeft
                                .px20
                                .width(context.screenWidth * 0.8)
                                .height(context.screenHeight * 0.07)
                                .make(),
                          ),
                          SizedBox(height: context.screenHeight * 0.03),
                          BlocBuilder<CheckuserloginedCubit,
                              CheckuserloginedState>(
                            builder: (context, loginState) {
                              if (loginState.isLoggined!) {
                                context
                                    .read<GetBookmarkedArticlesCubit>()
                                    .getBookmarkedArticles(loginState.userUid!);
                              }
                              return loginState.isLoggined!
                                  ? BlocBuilder<GetBookmarkedArticlesCubit,
                                      GetBookmarkedArticlesState>(
                                      builder: (context, bookmarkState) {
                                        return bookmarkState
                                                .savedArticlesId!.isNotEmpty
                                            ? Container(
                                                width:
                                                    context.screenWidth * 0.55,
                                                height:
                                                    context.screenHeight * 0.78,
                                                child: ValueListenableBuilder<
                                                        Box<HiveArticleData>>(
                                                    valueListenable: Boxes
                                                            .getArticleFromCloud()
                                                        .listenable(),
                                                    builder:
                                                        (context, value, _) {
                                                      if (bookmarkState
                                                          .savedArticlesId!
                                                          .isNotEmpty) {
                                                        value.values
                                                            .forEach((element) {
                                                          if (bookmarkState
                                                              .savedArticlesId!
                                                              .contains(element
                                                                  .documentId)) {
                                                            listOfArticles
                                                                .add(element);
                                                          }
                                                        });
                                                      }
                                                      return listOfArticles
                                                              .isNotEmpty
                                                          ? ListView.separated(
                                                              separatorBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      SizedBox(
                                                                        height: context.screenHeight *
                                                                            0.035,
                                                                      ),
                                                              physics:
                                                                  BouncingScrollPhysics(),
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  listOfArticles
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    // ignore: unused_local_variable
                                                                    CodeArticleData data = CodeArticleData(
                                                                        articleDescription: listOfArticles[index]
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
                                                                        authorUid: listOfArticles[index]
                                                                            .authorUid,
                                                                        bookmarkedBy: listOfArticles[index]
                                                                            .bookmarkedBy,
                                                                        country: listOfArticles[index]
                                                                            .country,
                                                                        documentId: listOfArticles[index]
                                                                            .documentId,
                                                                        galleryImages:
                                                                            listOfArticles[index]
                                                                                .galleryImages,
                                                                        isArticlePublished:
                                                                            listOfArticles[index]
                                                                                .isArticlePublished,
                                                                        isArticleReported:
                                                                            listOfArticles[index]
                                                                                .isArticleReported,
                                                                        noOfComments:
                                                                            listOfArticles[index]
                                                                                .noOfComments,
                                                                        noOfViews:
                                                                            listOfArticles[index]
                                                                                .noOfViews,
                                                                        noOflikes:
                                                                            listOfArticles[index]
                                                                                .noOflikes,
                                                                        socialMediaLink:
                                                                            listOfArticles[index].socialMediaLink);

                                                                    context.vxNav.push(
                                                                        Uri(
                                                                            path:
                                                                                MyRoutes.homeRoute,
                                                                            queryParameters: {
                                                                              "Page": "/Articles",
                                                                              "id": listOfArticles[index].documentId
                                                                            }),
                                                                        params:
                                                                            listOfArticles[index]);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: index.isOdd
                                                                            ? context.screenWidth *
                                                                                0.08
                                                                            : 0,
                                                                        right: index.isEven
                                                                            ? context.screenWidth *
                                                                                0.08
                                                                            : 0),
                                                                    child: HomePageCenterPaneArticleCard(
                                                                        index:
                                                                            index,
                                                                        listOfArticles: CodeArticleData(
                                                                            articleDescription:
                                                                                listOfArticles[index].articleDescription,
                                                                            articleLike: listOfArticles[index].articleLike,
                                                                            articlePhotoUrl: listOfArticles[index].articlePhotoUrl,
                                                                            articleReportedBy: listOfArticles[index].articleReportedBy,
                                                                            articleSubtype: listOfArticles[index].articleSubtype,
                                                                            articleTitle: listOfArticles[index].articleTitle,
                                                                            authorName: listOfArticles[index].authorName,
                                                                            authorUid: listOfArticles[index].authorUid,
                                                                            bookmarkedBy: listOfArticles[index].bookmarkedBy,
                                                                            country: listOfArticles[index].country,
                                                                            documentId: listOfArticles[index].documentId,
                                                                            galleryImages: listOfArticles[index].galleryImages,
                                                                            isArticlePublished: listOfArticles[index].isArticlePublished,
                                                                            isArticleReported: listOfArticles[index].isArticleReported,
                                                                            noOfComments: listOfArticles[index].noOfComments,
                                                                            noOfViews: listOfArticles[index].noOfViews,
                                                                            noOflikes: listOfArticles[index].noOflikes,
                                                                            socialMediaLink: listOfArticles[index].socialMediaLink)),
                                                                  ),
                                                                );
                                                              })
                                                          : Center(
                                                              child: Text(
                                                                  "Getting Articles"),
                                                            );
                                                    })).scrollVertical()
                                            : Center(
                                                child: Text("Getting Articles"),
                                              );
                                      },
                                    )

                                  /* StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('UserProfile')
                                          .doc(loginState.userUid)
                                          .collection('BookmarkedArticles')
                                          .orderBy('CreatedTime',
                                              descending: true)
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        return snapshot.hasData
                                            ? ListView.separated(
                                                controller: ScrollController(),
                                                physics: ScrollPhysics(),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                  height: context.screenHeight *
                                                      0.025,
                                                ),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot.data.docs.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      context.vxNav.push(Uri(
                                                          path: MyRoutes
                                                              .homeRoute,
                                                          queryParameters: {
                                                            "Page": "/Articles",
                                                            "id": snapshot.data
                                                                    .docs[index]
                                                                ['DocumentId']
                                                          }));
                                                    },
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(snapshot.data
                                                                  .docs[index]
                                                              ['ArticleTitle']),
                                                          SizedBox(
                                                              height: context
                                                                      .screenHeight *
                                                                  0.015),
                                                          Text(snapshot.data
                                                                  .docs[index]
                                                              ['AuthorName']),
                                                        ],
                                                      ),
                                                    )
                                                        .box
                                                        .p16
                                                        .width(context
                                                                .screenWidth *
                                                            0.65)
                                                        .height(context
                                                                .screenHeight *
                                                            0.15)
                                                        .border(
                                                            color: Colors.white,
                                                            width: 3)
                                                        .customRounded(
                                                            BorderRadius
                                                                .circular(12))
                                                        .neumorphic(
                                                          elevation: 16,
                                                          color: Colors.white,
                                                        )
                                                        .make(),
                                                  );
                                                },
                                              )
                                                .box
                                                .width(
                                                    context.screenWidth * 0.55)
                                                .height(
                                                    context.screenHeight * 0.78)
                                                .make()
                                            : Center(
                                                child: Text(
                                                    'Check Internet Connection'),
                                              );
                                      },
                                    ) */ //TODO: add here with Cubit
                                  : Center(
                                      child: Text(
                                          'Please Login Into Your Account'),
                                    );
                            },
                          )
                        ],
                      ),
                    ),
                    BodyRightPane(
                      isHome: false,
                      favouriteCategory: swapToFavouriteArticles,
                    )
                  ],
                ),
                HomePageFooter()
              ],
            )
                .scrollVertical()
                .box
                .width(context.screenWidth)
                .height(context.screenHeight * 0.9)
                .make()
          ],
        ),
      ),
    );
  }

  swapToFavouriteArticles(String screen) {
    context
        .read<ShowCurrentlySelectedSubtypeCubit>()
        .changeSelectedSubtypeTo(screen);
  }
}
