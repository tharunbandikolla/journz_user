import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journz_web/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';

class MobileArticleCard extends StatefulWidget {
  final int index;
  final List<HiveArticleData> listOfArticles;
  const MobileArticleCard(
      {Key? key, required this.index, required this.listOfArticles})
      : super(key: key);

  @override
  State<MobileArticleCard> createState() => _MobileArticleCardState();
}

class _MobileArticleCardState extends State<MobileArticleCard> {
  DateTime? currentPressedTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: context.screenWidth * 0.075,
                      maxHeight: context.screenWidth * 0.125,
                      minWidth: context.screenWidth * 0.825,
                      maxWidth: context.screenWidth * 0.825),
                  child: widget.listOfArticles[widget.index].articleTitle!.text
                      .xl.semiBold
                      .maxLines(2)
                      .overflow(TextOverflow.ellipsis)
                      .make(),
                ),
                /* widget
                    .listOfArticles[widget.index].articleTitle!.text.xl.semiBold
                    .maxLines(2)
                    .overflow(TextOverflow.ellipsis)
                    .make()
                    .box
                    .red200
                    .width(context.screenWidth * 0.875)
                    .height(context.screenWidth * 0.15)
                    .make(), */
                BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                  builder: (context, state) {
                    return state.isLoggined != null //state.isLoggined!
                        ? widget.listOfArticles[widget.index].bookmarkedBy
                                .contains(state.userUid)
                            ? const Icon(Icons.bookmark)
                            : const Icon(Icons.bookmark_border)
                        : const Icon(Icons.bookmark_border);
                  },
                )
              ]),
          /* .box
              .blue400
              .width(context.screenWidth * 0.95)
              .height(context.screenWidth * 0.125)
              .make(), */
          /*     Html(data: widget.listOfArticles[widget.index].articleDescription)
              .box
              .blue300
              .width(context.screenWidth * 0.95)
              .height(context.screenWidth * 0.2)
              .make(), */
          SizedBox(height: context.screenWidth * 0.015),
          Text(
            widget.listOfArticles[widget.index].articleDescription
                .split(RegExp("<(“[^”]*”|'[^’]*’|[^'”>])*>"))
                .join(" ")
                .split("&nbsp;")
                .join("")
                .split("&lt;")
                .join("")
                .split("&gt;")
                .join("")
                .split("&quot;")
                .join("")
                .split("&amp;")
                .join("")
                .split("&apos;")
                .join("")
                .split("&cent;")
                .join("")
                .split("&pound;")
                .join("")
                .split("&yen;")
                .join("")
                .split("&euro;")
                .join("")
                .split("&copy;")
                .join("")
                .split("&reg;")
                .join("")
                .split(".")
                .join(".\n")
                .trim(),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          )
              .box
              .width(context.screenWidth * 0.95)
              .height(context.screenWidth * 0.25)
              .make(),
          SizedBox(height: context.screenWidth * 0.0175),
          /*  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Icon(
                        FontAwesomeIcons.solidCommentDots,
                        color: Colors.black,
                        size: 20,
                      ),
                      widget.listOfArticles[widget.index].noOfComments.text
                          .make(),
                      "Comments".text.make()
                    ])
                    .box
                    .customRounded(BorderRadius.circular(4))
                    .neumorphic(color: Colors.white)
                    .width(context.screenWidth * 0.45)
                    .height(context.screenHeight * 0.05)
                    .make(),
                Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                        builder: (context, userState) {
                          return userState.isLoggined!
                              ? widget.listOfArticles[widget.index].articleLike
                                      .contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.black,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.black,
                                      size: 20,
                                    )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.black,
                                  size: 20,
                                );
                        },
                      ),
                      widget.listOfArticles[widget.index].noOflikes.text.make(),
                    ])
                    .box
                    .customRounded(BorderRadius.circular(4))
                    .neumorphic(color: Colors.white)
                    .width(context.screenWidth * 0.25)
                    .height(context.screenHeight * 0.05)
                    .make(),
                Icon(Icons.share)
                /* .box
                    .width(context.screenWidth * 0.05)
                    .height(context.screenHeight * 0.05)
                    .make() */
              ])
              .box
              .width(context.screenWidth * 0.95)
              .height(context.screenWidth * 0.075)
              .make(), */
          Container(
            width: context.screenWidth * 0.9,
            height: context.screenWidth * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.001),
                    width: context.screenWidth * 0.175,
                    height: context.screenWidth * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icon_eye.png',
                                color: Colors.black)
                            .box
                            .width(context.screenWidth * 0.05)
                            .height(context.screenWidth * 0.075)
                            .make(),
                        widget.listOfArticles[widget.index].noOfViews >= 1000 &&
                                widget.listOfArticles[widget.index].noOfViews <=
                                    999999
                            ? Text(
                                (widget.listOfArticles[widget.index].noOfViews /
                                            1000)
                                        .floor()
                                        .toString() +
                                    "K")
                            : widget.listOfArticles[widget.index].noOfViews >=
                                        1000000 &&
                                    widget.listOfArticles[widget.index]
                                            .noOfViews <=
                                        999999999
                                ? Text((widget.listOfArticles[widget.index]
                                                .noOfViews /
                                            1000000)
                                        .floor()
                                        .toString() +
                                    "M")
                                : Text(widget
                                    .listOfArticles[widget.index].noOfViews
                                    .toString()),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.001),
                  width: context.screenWidth * 0.175,
                  height: context.screenWidth * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/icon_new_chat.png',
                        color: Colors.black,
                      )
                          .box
                          .width(context.screenWidth * 0.05)
                          .height(context.screenWidth * 0.075)
                          .make(),
                      widget.listOfArticles[widget.index].noOfComments >= 1000 &&
                              widget.listOfArticles[widget.index].noOfComments <=
                                  999999
                          ? Text(
                              (widget.listOfArticles[widget.index].noOfComments /
                                          1000)
                                      .floor()
                                      .toString() +
                                  "K")
                          : widget.listOfArticles[widget.index].noOfComments >=
                                      1000000 &&
                                  widget.listOfArticles[widget.index]
                                          .noOfComments <=
                                      999999999
                              ? Text((widget.listOfArticles[widget.index]
                                              .noOfComments /
                                          1000000)
                                      .floor()
                                      .toString() +
                                  "M")
                              : Text(widget
                                  .listOfArticles[widget.index].noOfComments
                                  .toString()),
                    ],
                  ),
                ),
                BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                  builder: (context, loginState) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.screenWidth * 0.001),
                      width: context.screenWidth * 0.175,
                      height: context.screenWidth * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          loginState.isLoggined!
                              ? widget.listOfArticles[widget.index].articleLike
                                      .contains(loginState.userUid)
                                  ? Image.asset(
                                      'assets/images/Okay2.png',
                                      color: Colors.black,
                                    )
                                      .box
                                      .width(context.screenWidth * 0.05)
                                      .height(context.screenWidth * 0.075)
                                      .make()
                                  : Image.asset(
                                      'assets/images/Okayoutline1.png',
                                      color: Colors.black,
                                    )
                                      .box
                                      .width(context.screenWidth * 0.05)
                                      .height(context.screenWidth * 0.075)
                                      .make()
                              : Image.asset(
                                  'assets/images/Okayoutline1.png',
                                  color: Colors.black,
                                )
                                  .box
                                  .width(context.screenWidth * 0.05)
                                  .height(context.screenWidth * 0.075)
                                  .make(),
                          widget.listOfArticles[widget.index].noOflikes >= 1000 &&
                                  widget.listOfArticles[widget.index].noOflikes <=
                                      999999
                              ? Text((widget.listOfArticles[widget.index]
                                              .noOflikes /
                                          1000)
                                      .floor()
                                      .toString() +
                                  "K")
                              : widget.listOfArticles[widget.index].noOflikes >=
                                          1000000 &&
                                      widget.listOfArticles[widget.index]
                                              .noOflikes <=
                                          999999999
                                  ? Text((widget.listOfArticles[widget.index]
                                                  .noOflikes /
                                              1000000)
                                          .floor()
                                          .toString() +
                                      "M")
                                  : Text(widget
                                      .listOfArticles[widget.index].noOflikes
                                      .toString()),
                        ],
                      ),
                    );
                  },
                ),
                /*   BlocBuilder<
                                                    BookmarkarticlesCubit,
                                                    BookmarkarticlesState>(
                                                  builder:
                                                      (context, bookmarkState) {
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
                                                                    "ArticleTitle":
                                                                        widget
                                                                            .data!
                                                                            .articleTitle!,
                                                                    "AuthorName":
                                                                        widget
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
                                                                          loginState
                                                                              .userUid!,
                                                                          widget
                                                                              .docId));
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
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
                                                                        color: Colors
                                                                            .black,
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
                                                                        color: Colors
                                                                            .black,
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
                                                ), */
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.001),
                    width: context.screenWidth * 0.1,
                    height: context.screenWidth * 0.05,
                    child: InkWell(
                        onTap: () {
                          Share.share(
                              'Check This Page ${widget.listOfArticles[widget.index].socialMediaLink}');
                        },
                        child: Image.asset('assets/images/Sharefilled2.png',
                            color: Colors
                                .black))), /* 
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
                                                                0.05,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  context.vxNav.push(
                                                                      Uri(
                                                                          path:
                                                                              MyRoutes.homeRoute,
                                                                          queryParameters: {
                                                                            "Page":
                                                                                "/CreateArticle"
                                                                          }),
                                                                      params: {
                                                                        'isEditArticle':
                                                                            true,
                                                                        "articleData": CodeArticleData(
                                                                            articleDescription:
                                                                                widget.listOfArticles[widget.index].articleDescription,
                                                                            articleLike: widget.listOfArticles[widget.index].articleLike,
                                                                            articlePhotoUrl: widget.listOfArticles[widget.index].articlePhotoUrl,
                                                                            articleReportedBy: widget.listOfArticles[widget.index].articleReportedBy,
                                                                            articleSubtype: widget.listOfArticles[widget.index].articleSubtype,
                                                                            articleTitle: widget.listOfArticles[widget.index].articleTitle,
                                                                            authorName: widget.listOfArticles[widget.index].authorName,
                                                                            authorUid: widget.listOfArticles[widget.index].authorUid,
                                                                            bookmarkedBy: widget.listOfArticles[widget.index].bookmarkedBy,
                                                                            country: widget.listOfArticles[widget.index].country,
                                                                            documentId: widget.listOfArticles[widget.index].documentId,
                                                                            galleryImages: widget.listOfArticles[widget.index].galleryImages,
                                                                            isArticlePublished: widget.listOfArticles[widget.index].isArticlePublished,
                                                                            isArticleReported: widget.listOfArticles[widget.index].isArticleReported,
                                                                            noOfComments: widget.listOfArticles[widget.index].noOfComments,
                                                                            noOfViews: widget.listOfArticles[widget.index].noOfViews,
                                                                            noOflikes: widget.listOfArticles[widget.index].noOflikes,
                                                                            socialMediaLink: widget.listOfArticles[widget.index].socialMediaLink)
                                                                      });
                                                                },
                                                                child: Image.asset(
                                                                    'assets/images/edit.png',
                                                                    color: Colors
                                                                        .black)))
                                                        : Container()
                                                    : Container() */
              ],
            ),
          )
        ],
      ),
    )
        .box
        .withConstraints(BoxConstraints(
            minWidth: context.screenWidth,
            maxWidth: context.screenWidth,
            minHeight: context.screenWidth * 0.35))
        .border(color: Colors.white, width: 1.5)
        .customRounded(BorderRadius.circular(16))
        .neumorphic(color: Colors.white)
        .make();
  }
}
