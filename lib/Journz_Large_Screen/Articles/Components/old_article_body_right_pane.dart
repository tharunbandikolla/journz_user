/* import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journz_web/Common/Cubits/CheckInternetConnection/check_internet_connection_cubit.dart';

import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'package:journz_web/HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import 'package:journz_web/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:journz_web/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class OldArticleBodyRightPane extends StatefulWidget {
  final HiveArticleData? info;
  final String documenId;
  const OldArticleBodyRightPane({Key? key, required this.documenId, this.info})
      : super(key: key);

  @override
  _OldArticleBodyRightPaneState createState() =>
      _OldArticleBodyRightPaneState();
}

class _OldArticleBodyRightPaneState extends State<OldArticleBodyRightPane> {
  CodeArticleData streamData = CodeArticleData();
  var k;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void didChangeDependencies() {
    if (widget.info != null) {
      k = widget.info!.key;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: context.screenWidth * 0.015),
      color: Colors.grey.shade50,
      width: context.screenWidth * 0.6,
      height: context.screenHeight * 0.825,
      child: BlocBuilder<CheckInternetConnectionCubit,
          CheckInternetConnectionState>(
        builder: (context, internetState) {
          print(
              'nnn checkInternet at its Widget ${internetState.streamInternet}');
          return internetState.streamInternet!
              ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('NewArticleCollection')
                      .doc(widget.documenId)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      streamData = CodeArticleData.fromJson(snapshot.data);
                      if (widget.info != null) {
                        final newArticleData = HiveArticleData()
                          ..articleTitle = streamData.articleTitle
                          ..articleDescription = streamData.articleDescription!
                          ..articleLike = streamData.articleLike!
                          ..articlePhotoUrl = streamData.articlePhotoUrl!
                          ..articleSubtype = streamData.articleSubtype
                          ..authorName = streamData.authorName
                          ..authorUid = streamData.authorUid
                          ..bookmarkedBy = streamData.bookmarkedBy!
                          ..country = streamData.country!
                          ..documentId = streamData.documentId!
                          ..galleryImages = streamData.galleryImages!
                          ..isArticlePublished = streamData.isArticlePublished!
                          ..isArticleReported = streamData.isArticleReported!
                          ..noOfComments = streamData.noOfComments!
                          ..noOflikes = streamData.noOflikes!
                          ..noOfViews = streamData.noOfViews!
                          ..articleReportedBy = streamData.articleReportedBy!
                          ..socialMediaLink = streamData.socialMediaLink!;

                        final box = Boxes.getArticleFromCloud();

                        print('nnn key $k');
                        box.putAt(k, newArticleData);
                      }
                    }
                    return snapshot.hasError
                        ? Center(
                            child: Text('error'),
                          )
                        : snapshot.connectionState == ConnectionState.waiting
                            ? Center(
                                child: Text('Waiting'),
                              )
                            : snapshot.connectionState == ConnectionState.active
                                ? snapshot.hasData
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                            streamData
                                                .articleTitle!.text.xl4.bold
                                                .make(),
                                            SizedBox(
                                                height: context.screenHeight *
                                                    0.03),
                                            Html(
                                              data:
                                                  streamData.articleDescription,
                                              onLinkTap: (url, context,
                                                  attributes, element) {
                                                if (url != null) {
                                                  launch(url);
                                                }
                                              },
                                            ),
                                            SizedBox(
                                                height: context.screenHeight *
                                                    0.01),
                                            Container(
                                              width: context.screenWidth * 0.6,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      context.screenWidth *
                                                          0.003),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: context.screenWidth *
                                                        0.21,
                                                    height:
                                                        context.screenHeight *
                                                            0.035,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      context.screenWidth *
                                                                          0.001),
                                                          width: context
                                                                  .screenWidth *
                                                              0.07,
                                                          height: context
                                                                  .screenHeight *
                                                              0.035,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                  FontAwesomeIcons
                                                                      .eye),
                                                              Text(streamData
                                                                  .noOfViews
                                                                  .toString())
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      context.screenWidth *
                                                                          0.001),
                                                          width: context
                                                                  .screenWidth *
                                                              0.07,
                                                          height: context
                                                                  .screenHeight *
                                                              0.035,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(FontAwesomeIcons
                                                                  .commentDots),
                                                              Text(streamData
                                                                  .noOfComments
                                                                  .toString()),
                                                            ],
                                                          ),
                                                        ),
                                                        BlocBuilder<
                                                            CheckuserloginedCubit,
                                                            CheckuserloginedState>(
                                                          builder: (context,
                                                              loginState) {
                                                            return InkWell(
                                                              onTap: () {
                                                                if (loginState
                                                                    .isLoggined!) {
                                                                  if (streamData
                                                                      .articleLike!
                                                                      .contains(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'NewArticleCollection')
                                                                        .doc(widget
                                                                            .documenId)
                                                                        .update({
                                                                      'NoOfLikes':
                                                                          FieldValue.increment(
                                                                              -1)
                                                                    });

                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'NewArticleCollection')
                                                                        .doc(widget
                                                                            .documenId)
                                                                        .update({
                                                                      "ArticleLike":
                                                                          FieldValue
                                                                              .arrayRemove([
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid
                                                                      ])
                                                                    });
                                                                  } else {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'NewArticleCollection')
                                                                        .doc(widget
                                                                            .documenId)
                                                                        .update({
                                                                      'NoOfLikes':
                                                                          FieldValue.increment(
                                                                              1)
                                                                    });
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'NewArticleCollection')
                                                                        .doc(widget
                                                                            .documenId)
                                                                        .update({
                                                                      "ArticleLike":
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid
                                                                      ])
                                                                    });
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        context.screenWidth *
                                                                            0.001),
                                                                width: context
                                                                        .screenWidth *
                                                                    0.07,
                                                                height: context
                                                                        .screenHeight *
                                                                    0.035,
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
                                                                        ? streamData.articleLike!.contains(FirebaseAuth
                                                                                .instance.currentUser!.uid)
                                                                            ? Icon(Icons
                                                                                .favorite)
                                                                            : Icon(Icons
                                                                                .favorite_border_outlined)
                                                                        : Icon(Icons
                                                                            .favorite_border_outlined),
                                                                    Text(streamData
                                                                        .noOflikes
                                                                        .toString()),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: context
                                                                .screenWidth *
                                                            0.001),
                                                    width: context.screenWidth *
                                                        0.35,
                                                    height:
                                                        context.screenWidth *
                                                            0.035,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        "Author : ${streamData.authorName}"
                                                            .text
                                                            .xl2
                                                            .make(),
                                                        SizedBox(
                                                            width: context
                                                                    .screenWidth *
                                                                0.01),
                                                        Icon(Icons.share)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ]).scrollVertical()
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      )
                                : Center(
                                    child: Text('connection not active'),
                                  );
                  },
                )
              : widget.info != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          widget.info!.articleTitle!.text.xl4.bold.make(),
                          SizedBox(height: context.screenHeight * 0.03),
                          Html(
                            data: widget.info!.articleDescription,
                            onLinkTap: (url, context, attributes, element) {
                              if (url != null) {
                                launch(url);
                              }
                            },
                          ),
                          SizedBox(height: context.screenHeight * 0.01),
                          Container(
                            width: context.screenWidth * 0.6,
                            padding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth * 0.003),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: context.screenWidth * 0.21,
                                  height: context.screenHeight * 0.035,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                context.screenWidth * 0.001),
                                        width: context.screenWidth * 0.07,
                                        height: context.screenHeight * 0.035,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.eye),
                                            Text(widget.info!.noOfViews
                                                .toString())
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                context.screenWidth * 0.001),
                                        width: context.screenWidth * 0.07,
                                        height: context.screenHeight * 0.035,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.commentDots),
                                            Text(widget.info!.noOfComments
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                      BlocBuilder<CheckuserloginedCubit,
                                          CheckuserloginedState>(
                                        builder: (context, loginState) {
                                          return InkWell(
                                            onTap: () {
                                              if (loginState.isLoggined!) {
                                                if (widget.info!.articleLike
                                                    .contains(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid)) {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'NewArticleCollection')
                                                      .doc(widget.documenId)
                                                      .update({
                                                    'NoOfLikes':
                                                        FieldValue.increment(-1)
                                                  });

                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'NewArticleCollection')
                                                      .doc(widget.documenId)
                                                      .update({
                                                    "ArticleLike":
                                                        FieldValue.arrayRemove([
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                    ])
                                                  });
                                                } else {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'NewArticleCollection')
                                                      .doc(widget.documenId)
                                                      .update({
                                                    'NoOfLikes':
                                                        FieldValue.increment(1)
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'NewArticleCollection')
                                                      .doc(widget.documenId)
                                                      .update({
                                                    "ArticleLike":
                                                        FieldValue.arrayUnion([
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                    ])
                                                  });
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      context.screenWidth *
                                                          0.001),
                                              width: context.screenWidth * 0.07,
                                              height:
                                                  context.screenHeight * 0.035,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  loginState.isLoggined!
                                                      ? widget.info!.articleLike
                                                              .contains(
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                          ? Icon(Icons.favorite)
                                                          : Icon(Icons
                                                              .favorite_border_outlined)
                                                      : Icon(Icons
                                                          .favorite_border_outlined),
                                                  Text(widget.info!.noOflikes
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.screenWidth * 0.001),
                                  width: context.screenWidth * 0.35,
                                  height: context.screenWidth * 0.035,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      "Author : ${widget.info!.authorName}"
                                          .text
                                          .xl2
                                          .make(),
                                      SizedBox(
                                          width: context.screenWidth * 0.01),
                                      Icon(Icons.share)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]).scrollVertical()
                  : Center(
                      child: Text('Please Check Your Internet Connection'),
                    );
        },
      ),
    );
  }
}
 */