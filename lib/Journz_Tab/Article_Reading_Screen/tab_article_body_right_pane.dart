import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../Journz_Large_Screen/HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import '../../Journz_Large_Screen/NewHomePage/Cubits/ShowCurrentlySelectedSubtypeCubit/show_currently_selected_subtype_cubit.dart';
import '../../Journz_Large_Screen/utils/routes.dart';
import '../../Journz_Mobile/HomePage/mobile_home_page_footer.dart';
import '../tab_home_footer.dart';
import '/Journz_Large_Screen/Articles/Comments/code_articles_comment_model.dart';
import '/Journz_Large_Screen/Articles/Comments/hive_articles_comments.dart';
import '/Journz_Large_Screen/Articles/Cubit/ShowArticleData/show_article_data_cubit.dart';
import '/Journz_Large_Screen/Articles/Cubit/ShowCommentCubit/show_comment_cubit.dart';
import '/Journz_Large_Screen/Articles/Cubit/bookmark_articles_cubit/bookmarkarticles_cubit.dart';

import '/Journz_Large_Screen/Common/Helper/dialogs.dart';
import '/Journz_Large_Screen/Common/Helper/time_stamp_reader.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_body_right_pane.dart';
import '/Journz_Large_Screen/NewHomePage/Components/home_page_footer.dart';
import '/Journz_Large_Screen/NewHomePage/Components/left_pane_profile.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:random_string/random_string.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TabArticleBodyRightPane extends StatefulWidget {
  final HiveArticleData? data;
  final docId;
  const TabArticleBodyRightPane({Key? key, required this.docId, this.data})
      : super(key: key);

  @override
  _TabArticleBodyRightPaneState createState() =>
      _TabArticleBodyRightPaneState();
}

class _TabArticleBodyRightPaneState extends State<TabArticleBodyRightPane> {
  TextEditingController commentController = TextEditingController();
  DateTime? currentPressedTime;
  @override
  Widget build(BuildContext context) {
    final showArticleData = BlocProvider.of<ShowArticleDataCubit>(context);
    final checkUser = BlocProvider.of<CheckuserloginedCubit>(context);

    checkUser.checkLogin();
    final showCommentCubit = BlocProvider.of<ShowCommentCubit>(context);

    return BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
      builder: (context, loginState) {
        if (loginState.isLoggined!) {
          if (widget.data != null) {
            final bookmark = BlocProvider.of<BookmarkarticlesCubit>(context);
            bookmark.listenForBookmark(loginState.userUid!, widget.docId);
          }
        }
        return Container(
            // padding: EdgeInsets.only(left: context.screenWidth * 0.015),

            width: context.screenWidth,
            //height: context.screenWidth * 0.9,
            child: ValueListenableBuilder<Box<HiveArticleData>>(
              valueListenable: Boxes.getArticleFromCloud().listenable(),
              builder: (context, value, __) {
                value.values.forEach((element) {
                  if (widget.docId != null) {
                    if (element.documentId == widget.docId) {
                      showArticleData.passArticleData(element);
                    }
                  }
                });
                return BlocBuilder<ShowArticleDataCubit, ShowArticleDataState>(
                  builder: (context, articleState) {
                    return articleState.hiveArticleData != null
                        ? Container(
                            width: context.screenWidth,
                            //height: context.screenWidth * 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //LeftPaneProfile(),
                                    Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          articleState.hiveArticleData!
                                                      .articlePhotoUrl !=
                                                  "WithoutImage"
                                              ? Image.network(
                                                  articleState.hiveArticleData!
                                                      .articlePhotoUrl,
                                                  fit: BoxFit.fill,
                                                  width:
                                                      context.screenWidth * 0.9,
                                                  height: context.screenWidth *
                                                      0.15,
                                                )
                                                  .box
                                                  .width(
                                                      context.screenWidth * 0.9)
                                                  .height(context.screenWidth *
                                                      0.45)
                                                  .make()
                                              : Container(),
                                          articleState
                                              .hiveArticleData!
                                              .articleTitle!
                                              .selectableText
                                              .xl4
                                              .bold
                                              .make(),
                                          SizedBox(
                                              height:
                                                  context.screenWidth * 0.005),
                                          SelectableHtml(
                                            data: articleState.hiveArticleData!
                                                .articleDescription,
                                            onLinkTap: (url, context,
                                                attributes, element) {
                                              if (url != null) {
                                                launch(url);
                                              }
                                            },
                                          ),
                                          /* SizedBox(
                                              height:
                                                  context.screenWidth * 0.00), */
                                          Container(
                                            width: context.screenWidth * 0.9,
                                            /*  padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    context.screenWidth *
                                                        0.003), */
                                            child: Container(
                                              width: context.screenWidth * 0.9,
                                              height: context.screenWidth * 0.1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: context
                                                                .screenWidth *
                                                            0.001),
                                                    width: context.screenWidth *
                                                        0.1,
                                                    height:
                                                        context.screenWidth *
                                                            0.1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                                'assets/images/icon_eye.png',
                                                                color: Colors
                                                                    .black)
                                                            .box
                                                            .width(context
                                                                    .screenWidth *
                                                                0.05)
                                                            .height(context
                                                                    .screenWidth *
                                                                0.075)
                                                            .make(),
                                                        articleState.hiveArticleData!
                                                                        .noOfViews >=
                                                                    1000 &&
                                                                articleState
                                                                        .hiveArticleData!
                                                                        .noOfViews <=
                                                                    999999
                                                            ? Text((articleState
                                                                            .hiveArticleData!
                                                                            .noOfViews /
                                                                        1000)
                                                                    .floor()
                                                                    .toString() +
                                                                "K")
                                                            : articleState.hiveArticleData!
                                                                            .noOfViews >=
                                                                        1000000 &&
                                                                    articleState
                                                                            .hiveArticleData!
                                                                            .noOfViews <=
                                                                        999999999
                                                                ? Text((articleState.hiveArticleData!.noOfViews /
                                                                            1000000)
                                                                        .floor()
                                                                        .toString() +
                                                                    "M")
                                                                : Text(articleState
                                                                    .hiveArticleData!
                                                                    .noOfViews
                                                                    .toString()),
                                                      ],
                                                    )
                                                        .box
                                                        .width(context
                                                                .screenWidth *
                                                            0.018)
                                                        .make(),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: context
                                                                .screenWidth *
                                                            0.001),
                                                    width: context.screenWidth *
                                                        0.1,
                                                    height:
                                                        context.screenWidth *
                                                            0.1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/icon_new_chat.png',
                                                          color: Colors.black,
                                                        )
                                                            .box
                                                            .width(context
                                                                    .screenWidth *
                                                                0.05)
                                                            .height(context
                                                                    .screenWidth *
                                                                0.075)
                                                            .make(),
                                                        articleState.hiveArticleData!
                                                                        .noOfComments >=
                                                                    1000 &&
                                                                articleState
                                                                        .hiveArticleData!
                                                                        .noOfComments <=
                                                                    999999
                                                            ? Text((articleState
                                                                            .hiveArticleData!
                                                                            .noOfComments /
                                                                        1000)
                                                                    .floor()
                                                                    .toString() +
                                                                "K")
                                                            : articleState.hiveArticleData!
                                                                            .noOfComments >=
                                                                        1000000 &&
                                                                    articleState
                                                                            .hiveArticleData!
                                                                            .noOfComments <=
                                                                        999999999
                                                                ? Text((articleState.hiveArticleData!.noOfComments /
                                                                            1000000)
                                                                        .floor()
                                                                        .toString() +
                                                                    "M")
                                                                : Text(articleState
                                                                    .hiveArticleData!
                                                                    .noOfComments
                                                                    .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      DateTime now =
                                                          DateTime.now();
                                                      if (currentPressedTime ==
                                                              null ||
                                                          now.difference(
                                                                  currentPressedTime ??
                                                                      now) >
                                                              const Duration(
                                                                  seconds: 1)) {
                                                        currentPressedTime =
                                                            now;
                                                        if (loginState
                                                            .isLoggined!) {
                                                          if (articleState
                                                              .hiveArticleData!
                                                              .articleLike
                                                              .contains(loginState
                                                                  .userUid)) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'NewArticleCollection')
                                                                .doc(widget
                                                                    .docId)
                                                                .update({
                                                              'NoOfLikes':
                                                                  FieldValue
                                                                      .increment(
                                                                          -1),
                                                              "ArticleLike":
                                                                  FieldValue
                                                                      .arrayRemove([
                                                                loginState
                                                                    .userUid
                                                              ])
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(error
                                                                    .toString()
                                                                    .split(
                                                                        ']')[1]),
                                                              ));
                                                              // ignore: null_argument_to_non_null_type
                                                              return Future
                                                                  .value();
                                                            });
                                                          } else {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'NewArticleCollection')
                                                                .doc(widget
                                                                    .docId)
                                                                .update({
                                                              'NoOfLikes':
                                                                  FieldValue
                                                                      .increment(
                                                                          1),
                                                              "ArticleLike":
                                                                  FieldValue
                                                                      .arrayUnion([
                                                                loginState
                                                                    .userUid
                                                              ])
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(error
                                                                    .toString()
                                                                    .split(
                                                                        ']')[1]),
                                                              ));
                                                              // ignore: null_argument_to_non_null_type
                                                              return Future
                                                                  .value();
                                                            });
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            content: Text(
                                                                'Please Login into Your Account'),
                                                          ));
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: context
                                                                  .screenWidth *
                                                              0.001),
                                                      width:
                                                          context.screenWidth *
                                                              0.1,
                                                      height:
                                                          context.screenWidth *
                                                              0.1,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          loginState.isLoggined!
                                                              ? articleState
                                                                      .hiveArticleData!
                                                                      .articleLike
                                                                      .contains(
                                                                          loginState
                                                                              .userUid)
                                                                  ? Image.asset(
                                                                      'assets/images/Okay2.png',
                                                                      color: Colors
                                                                          .black,
                                                                    )
                                                                      .box
                                                                      .width(context.screenWidth *
                                                                          0.05)
                                                                      .height(context.screenWidth *
                                                                          0.075)
                                                                      .make()
                                                                  : Image.asset(
                                                                      'assets/images/Okayoutline1.png',
                                                                      color: Colors
                                                                          .black,
                                                                    )
                                                                      .box
                                                                      .width(context
                                                                              .screenWidth *
                                                                          0.05)
                                                                      .height(context
                                                                              .screenWidth *
                                                                          0.075)
                                                                      .make()
                                                              : Image.asset(
                                                                  'assets/images/Okayoutline1.png',
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                                  .box
                                                                  .width(context
                                                                          .screenWidth *
                                                                      0.05)
                                                                  .height(context
                                                                          .screenWidth *
                                                                      0.075)
                                                                  .make(),
                                                          articleState.hiveArticleData!
                                                                          .noOflikes >=
                                                                      1000 &&
                                                                  articleState
                                                                          .hiveArticleData!
                                                                          .noOflikes <=
                                                                      999999
                                                              ? Text((articleState
                                                                              .hiveArticleData!
                                                                              .noOflikes /
                                                                          1000)
                                                                      .floor()
                                                                      .toString() +
                                                                  "K")
                                                              : articleState.hiveArticleData!
                                                                              .noOflikes >=
                                                                          1000000 &&
                                                                      articleState
                                                                              .hiveArticleData!
                                                                              .noOflikes <=
                                                                          999999999
                                                                  ? Text((articleState.hiveArticleData!.noOflikes /
                                                                              1000000)
                                                                          .floor()
                                                                          .toString() +
                                                                      "M")
                                                                  : Text(articleState
                                                                      .hiveArticleData!
                                                                      .noOflikes
                                                                      .toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  BlocBuilder<
                                                      BookmarkarticlesCubit,
                                                      BookmarkarticlesState>(
                                                    builder: (context,
                                                        bookmarkState) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          DateTime now =
                                                              DateTime.now();
                                                          if (currentPressedTime ==
                                                                  null ||
                                                              now.difference(
                                                                      currentPressedTime ??
                                                                          now) >
                                                                  const Duration(
                                                                      seconds:
                                                                          1)) {
                                                            currentPressedTime =
                                                                now;

                                                            if (loginState
                                                                .isLoggined!) {
                                                              print('Bookmark');
                                                              if (widget.data !=
                                                                  null) {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'UserProfile')
                                                                    .doc(loginState
                                                                        .userUid)
                                                                    .collection(
                                                                        'BookmarkedArticles')
                                                                    .where(
                                                                        'DocumentId',
                                                                        isEqualTo:
                                                                            widget
                                                                                .docId)
                                                                    .get()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .size !=
                                                                      0) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'UserProfile')
                                                                        .doc(loginState
                                                                            .userUid)
                                                                        .collection(
                                                                            'BookmarkedArticles')
                                                                        .doc(widget
                                                                            .docId)
                                                                        .delete();
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "NewArticleCollection")
                                                                        .doc(widget
                                                                            .docId)
                                                                        .update({
                                                                      "BookmarkedBy":
                                                                          FieldValue
                                                                              .arrayRemove([
                                                                        loginState
                                                                            .userUid
                                                                      ])
                                                                    });
                                                                  } else {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'UserProfile')
                                                                        .doc(loginState
                                                                            .userUid)
                                                                        .collection(
                                                                            'BookmarkedArticles')
                                                                        .doc(widget
                                                                            .docId)
                                                                        .set({
                                                                      'DocumentId':
                                                                          widget
                                                                              .docId,
                                                                      "ArticleTitle": widget
                                                                          .data!
                                                                          .articleTitle!,
                                                                      "AuthorName": widget
                                                                          .data!
                                                                          .authorName,
                                                                      "CreatedTime":
                                                                          FieldValue
                                                                              .serverTimestamp()
                                                                    });
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "NewArticleCollection")
                                                                        .doc(widget
                                                                            .docId)
                                                                        .update({
                                                                      "BookmarkedBy":
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        loginState
                                                                            .userUid
                                                                      ])
                                                                    });
                                                                  }
                                                                }).whenComplete(() => context
                                                                        .read<
                                                                            BookmarkarticlesCubit>()
                                                                        .listenForBookmark(
                                                                            loginState.userUid!,
                                                                            widget.docId));
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                    'Please Login into Your Account'),
                                                              ));
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      context.screenWidth *
                                                                          0.001),
                                                          width: context
                                                                  .screenWidth *
                                                              0.1,
                                                          height: context
                                                                  .screenWidth *
                                                              0.1,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              loginState
                                                                      .isLoggined!
                                                                  ? bookmarkState
                                                                          .isBookmarked
                                                                      ? Image
                                                                              .asset(
                                                                          'assets/images/icon_new_bookmark_filled.png',
                                                                          color:
                                                                              Colors.black,
                                                                        )
                                                                          .box
                                                                          .width(context.screenWidth *
                                                                              0.05)
                                                                          .height(context.screenWidth *
                                                                              0.05)
                                                                          .make()
                                                                      : Image
                                                                              .asset(
                                                                          'assets/images/icon_new_bookmark.png',
                                                                          color:
                                                                              Colors.black,
                                                                        )
                                                                          .box
                                                                          .width(context.screenWidth *
                                                                              0.05)
                                                                          .height(context.screenWidth *
                                                                              0.05)
                                                                          .make()
                                                                  : Image.asset(
                                                                      'assets/images/bookmark.png',
                                                                      color: Colors
                                                                          .black,
                                                                    )
                                                                      .box
                                                                      .width(context
                                                                              .screenWidth *
                                                                          0.05)
                                                                      .height(context
                                                                              .screenWidth *
                                                                          0.05)
                                                                      .make(),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: context
                                                                  .screenWidth *
                                                              0.001),
                                                      width:
                                                          context.screenWidth *
                                                              0.1,
                                                      height:
                                                          context.screenWidth *
                                                              0.05,
                                                      child: InkWell(
                                                          onTap: () {
                                                            Share.share(
                                                                'Check This Page ${articleState.hiveArticleData!.socialMediaLink}');
                                                          },
                                                          child: Image.asset(
                                                              'assets/images/Sharefilled2.png',
                                                              color: Colors
                                                                  .black))),
                                                  articleState.hiveArticleData!
                                                              .isArticlePublished ==
                                                          "UnderReview"
                                                      ? articleState
                                                                  .hiveArticleData!
                                                                  .authorUid ==
                                                              loginState.userUid
                                                          ? Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      context.screenWidth *
                                                                          0.001),
                                                              width: context
                                                                      .screenWidth *
                                                                  0.1,
                                                              height: context
                                                                      .screenWidth *
                                                                  0.1,
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    context.vxNav.push(
                                                                        Uri(
                                                                            path:
                                                                                MyRoutes.homeRoute,
                                                                            queryParameters: {
                                                                              "Page": "/CreateArticle"
                                                                            }),
                                                                        params: {
                                                                          'isEditArticle':
                                                                              true,
                                                                          "articleData": CodeArticleData(
                                                                              articleDescription: articleState.hiveArticleData!.articleDescription,
                                                                              articleLike: articleState.hiveArticleData!.articleLike,
                                                                              articlePhotoUrl: articleState.hiveArticleData!.articlePhotoUrl,
                                                                              articleReportedBy: articleState.hiveArticleData!.articleReportedBy,
                                                                              articleSubtype: articleState.hiveArticleData!.articleSubtype,
                                                                              articleTitle: articleState.hiveArticleData!.articleTitle,
                                                                              authorName: articleState.hiveArticleData!.authorName,
                                                                              authorUid: articleState.hiveArticleData!.authorUid,
                                                                              bookmarkedBy: articleState.hiveArticleData!.bookmarkedBy,
                                                                              country: articleState.hiveArticleData!.country,
                                                                              documentId: articleState.hiveArticleData!.documentId,
                                                                              galleryImages: articleState.hiveArticleData!.galleryImages,
                                                                              isArticlePublished: articleState.hiveArticleData!.isArticlePublished,
                                                                              isArticleReported: articleState.hiveArticleData!.isArticleReported,
                                                                              noOfComments: articleState.hiveArticleData!.noOfComments,
                                                                              noOfViews: articleState.hiveArticleData!.noOfViews,
                                                                              noOflikes: articleState.hiveArticleData!.noOflikes,
                                                                              socialMediaLink: articleState.hiveArticleData!.socialMediaLink)
                                                                        });
                                                                  },
                                                                  child: Image.asset(
                                                                      'assets/images/edit.png',
                                                                      color: Colors
                                                                          .black)))
                                                          : Container()
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  context.screenWidth * 0.015),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    context.screenWidth *
                                                        0.005),
                                            width: context.screenWidth * 0.9,
                                            height: context.screenWidth * 0.05,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                "Author : ${articleState.hiveArticleData!.authorName}"
                                                    .text
                                                    .xl
                                                    .make(),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  context.screenWidth * 0.015),
                                          /*  SizedBox(
                                              width: context.screenWidth,
                                              height:
                                                  context.screenWidth * 0.01), */
                                          BlocBuilder<CheckuserloginedCubit,
                                              CheckuserloginedState>(
                                            builder: (context, loginState) {
                                              return TextField(
                                                controller: commentController,
                                                maxLength: 200,
                                                decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                          if (commentController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              commentController
                                                                  .text
                                                                  .isNotBlank) {
                                                            if (widget.docId !=
                                                                null) {
                                                              if (loginState
                                                                  .isLoggined!) {
                                                                String
                                                                    documentId =
                                                                    randomAlphaNumeric(
                                                                        18);
                                                                CodeArticlesCommentModel model = CodeArticlesCommentModel(
                                                                    commentDocId:
                                                                        documentId,
                                                                    commentName:
                                                                        loginState
                                                                            .name,
                                                                    commentUid:
                                                                        loginState
                                                                            .userUid,
                                                                    comment: commentController
                                                                        .text
                                                                        .trim(),
                                                                    timeStamp:
                                                                        FieldValue
                                                                            .serverTimestamp(),
                                                                    commentTime:
                                                                        DateTime.now()
                                                                            .toString());
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'NewArticleCollection')
                                                                    .doc(widget
                                                                        .docId)
                                                                    .collection(
                                                                        'Comments')
                                                                    .doc(
                                                                        documentId)
                                                                    .set(model
                                                                        .toJson())
                                                                    .whenComplete(
                                                                        () {
                                                                  commentController
                                                                      .clear();
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'NewArticleCollection')
                                                                      .doc(widget
                                                                          .docId)
                                                                      .update({
                                                                    'NoOfComments':
                                                                        FieldValue
                                                                            .increment(1)
                                                                  }).then((value) =>
                                                                          listenForComments());
                                                                }).onError((error,
                                                                        stackTrace) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                    content: Text(error
                                                                        .toString()
                                                                        .split(
                                                                            ']')[1]),
                                                                  ));
                                                                  // ignore: null_argument_to_non_null_type
                                                                  return Future
                                                                      .value();
                                                                });
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      'Please Login into your Account'),
                                                                ));
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                content: Text(
                                                                    'Please Enter Comment'),
                                                              ));
                                                            }
                                                          }
                                                        },
                                                        icon: Icon(Icons.send)),
                                                    hintText:
                                                        "Write Comment Here",
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(context
                                                                    .screenSize
                                                                    .aspectRatio *
                                                                7))),
                                              );
                                            },
                                          ),
                                          /*  SizedBox(
                                              width: context.screenWidth,
                                              height:
                                                  context.screenWidth * 0.01), */
                                          'Comments'
                                              .text
                                              .xl3
                                              .bold
                                              .make()
                                              .box
                                              .alignCenterLeft
                                              .width(context.screenWidth)
                                              .height(context.screenWidth * 0.1)
                                              .make(),
                                          /* SizedBox(
                                              width: context.screenWidth,
                                              height:
                                                  context.screenWidth * 0.01), */
                                          ValueListenableBuilder<
                                              Box<HiveArticlesComments>>(
                                            valueListenable: Boxes
                                                    .getArticleCommentsFromCloud()
                                                .listenable(),
                                            builder: (context, value, child) {
                                              if (value.values.isNotEmpty) {
                                                showCommentCubit.listenForComment(value
                                                    .values
                                                    .sortedByNum((element) =>
                                                        DateTime.parse(element
                                                                .commentTime)
                                                            .millisecondsSinceEpoch)
                                                    .reversed
                                                    .toList()
                                                    .cast<
                                                        HiveArticlesComments>());
                                              }
                                              return BlocBuilder<
                                                  ShowCommentCubit,
                                                  ShowCommentState>(
                                                builder:
                                                    (context, commentState) {
                                                  return commentState
                                                              .listOfComment !=
                                                          null
                                                      ? ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: commentState
                                                              .listOfComment!
                                                              .length,
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (context, idx) {
                                                            return Container(
                                                                constraints: BoxConstraints(
                                                                    minWidth: context
                                                                        .screenWidth,
                                                                    maxWidth: context
                                                                        .screenWidth,
                                                                    minHeight:
                                                                        context.screenWidth *
                                                                            0.075,
                                                                    maxHeight: double
                                                                        .infinity),
                                                                margin: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        context.screenWidth *
                                                                            0.01,
                                                                    vertical: context.screenWidth *
                                                                        0.01),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        context.screenWidth *
                                                                            0.01,
                                                                    vertical:
                                                                        context.screenWidth *
                                                                            0.01),
                                                                decoration: BoxDecoration(
                                                                    color: Colors.grey.shade200,
                                                                    borderRadius: BorderRadius.circular(context.screenSize.aspectRatio * 5)),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(commentState.listOfComment![idx].commentName)
                                                                            .text
                                                                            .xl
                                                                            .semiBold
                                                                            .make(),
                                                                        BlocBuilder<
                                                                            CheckuserloginedCubit,
                                                                            CheckuserloginedState>(
                                                                          builder:
                                                                              (context, loginState) {
                                                                            return PopupMenuButton(
                                                                              icon: Icon(Icons.more_vert_outlined),
                                                                              itemBuilder: (context) {
                                                                                return [
                                                                                  PopupMenuItem(
                                                                                    value: 'delete',
                                                                                    child: Text("Delete"),
                                                                                  ),
                                                                                  PopupMenuItem(
                                                                                    child: Text("Report"),
                                                                                    value: 2,
                                                                                  )
                                                                                ];
                                                                              },
                                                                              onSelected: (value) {
                                                                                print('nnn value ');
                                                                                if (value == 'delete') {
                                                                                  if (loginState.userUid == commentState.listOfComment![idx].commentUid) {
                                                                                    deleteComment(widget.docId, commentState.listOfComment![idx].commentDocId, idx);
                                                                                  }
                                                                                } else {
                                                                                  ShowErrorDialogNormal(context, 'UnAuthorized Action');
                                                                                }
                                                                              },
                                                                            );
                                                                          },
                                                                        )
                                                                      ],
                                                                    ),
                                                                    readTimestamp(
                                                                            DateTime.parse(commentState.listOfComment![idx].commentTime).millisecondsSinceEpoch)
                                                                        .selectableText
                                                                        .light
                                                                        .make(),
                                                                    SizedBox(
                                                                        width: context
                                                                            .screenWidth,
                                                                        height: context.screenWidth *
                                                                            0.005),
                                                                    commentState
                                                                        .listOfComment![
                                                                            idx]
                                                                        .comment
                                                                        .selectableText
                                                                        .lg
                                                                        .make(),
                                                                  ],
                                                                ));
                                                          },
                                                        )
                                                      : SelectableText(
                                                          'Be The First One To Comment');
                                                },
                                              );
                                            },
                                          ),
                                          SizedBox(
                                              height:
                                                  context.screenWidth * 0.05)
                                        ])
                                        .box
                                        .width(context.screenWidth * 0.9)
                                        .make(),
                                    /* BodyRightPane(
                                      isHome: false,
                                      favouriteCategory:
                                          swapToFavouriteArticles,
                                    ) */
                                  ],
                                ),
                                TabHomePageFooter()
                              ],
                            ).scrollVertical(),
                          )
                        : Center(child: CircularProgressIndicator());
                  },
                );
              },
            ));
      },
    );
  }

  swapToFavouriteArticles(String screen) {
    context
        .read<ShowCurrentlySelectedSubtypeCubit>()
        .changeSelectedSubtypeTo(screen);
  }

  deleteComment(String docid, String secDocId, int index) {
    FirebaseFirestore.instance
        .collection('NewArticleCollection')
        .doc(docid)
        .update({'NoOfComments': FieldValue.increment(-1)}).then((value) {
      //  comments.removeAt(index);
      //context.read<ShowCommentCubit>().listenForComment(comments);
      FirebaseFirestore.instance
          .collection('NewArticleCollection')
          .doc(docid)
          .collection('Comments')
          .doc(secDocId)
          .delete()
          .then((value) => listenForComments());
    });
  }

/* 
  ShowErrorDialog(BuildContext ctx, Object? error) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text(error.toString().split(']').last),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
  }
 */
  listenForComments() {
    if (widget.docId != null) {
      final clearBox = Boxes.getArticleCommentsFromCloud();
      clearBox.clear();

      FirebaseFirestore.instance
          .collection('NewArticleCollection')
          .doc(widget.docId)
          .collection('Comments')
          .orderBy('TimeStamp')
          .get()
          .then((event) {
        if (event.size != 0) {
          event.docs.forEach((element) async {
            CodeArticlesCommentModel model =
                CodeArticlesCommentModel.fromJson(element);

            final data = HiveArticlesComments()
              ..comment = model.comment!
              ..commentName = model.commentName!
              ..commentTime = model.commentTime!
              ..commentUid = model.commentUid!
              ..commentDocId = model.commentDocId!;

            final box = Boxes.getArticleCommentsFromCloud();
            box.put(model.commentTime, data);
          });
        } else {
          context.read<ShowCommentCubit>().listenForComment(null);
        }
      }, onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString().split(']').last)));
      });
    }
  }
}
