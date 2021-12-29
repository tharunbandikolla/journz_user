import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journz_web/Articles/Comments/code_articles_comment_model.dart';
import 'package:journz_web/Articles/Comments/hive_articles_comments.dart';
import 'package:journz_web/Articles/Cubit/ShowArticleData/show_article_data_cubit.dart';
import 'package:journz_web/Common/Cubits/CheckInternetConnection/check_internet_connection_cubit.dart';
import 'package:journz_web/Common/Helper/time_stamp_reader.dart';

import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'package:journz_web/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:journz_web/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArticleBodyRightPane extends StatefulWidget {
  final HiveArticleData? data;
  final docId;
  const ArticleBodyRightPane({Key? key, required this.docId, this.data})
      : super(key: key);

  @override
  _ArticleBodyRightPaneState createState() => _ArticleBodyRightPaneState();
}

class _ArticleBodyRightPaneState extends State<ArticleBodyRightPane> {
  TextEditingController commentController = TextEditingController();
  List<HiveArticlesComments> listOfComments = [];
  @override
  Widget build(BuildContext context) {
    final showArticleData = BlocProvider.of<ShowArticleDataCubit>(context);
    final checkInternet =
        BlocProvider.of<CheckInternetConnectionCubit>(context);
    checkInternet.listenForInternet();
    return Container(
        padding: EdgeInsets.only(left: context.screenWidth * 0.015),
        color: Colors.grey.shade50,
        width: context.screenWidth * 0.7,
        height: context.screenHeight * 0.825,
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
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            articleState
                                .hiveArticleData!.articleTitle!.text.xl4.bold
                                .make(),
                            SizedBox(height: context.screenHeight * 0.03),
                            Html(
                              data: articleState
                                  .hiveArticleData!.articleDescription,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              Text(articleState
                                                  .hiveArticleData!.noOfViews
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
                                              Icon(
                                                  FontAwesomeIcons.commentDots),
                                              Text(articleState
                                                  .hiveArticleData!.noOfComments
                                                  .toString()),
                                            ],
                                          ),
                                        ),
                                        BlocBuilder<CheckuserloginedCubit,
                                            CheckuserloginedState>(
                                          builder: (context, loginState) {
                                            return InkWell(
                                              onTap: () async {
                                                ConnectivityResult result =
                                                    await Connectivity()
                                                        .checkConnectivity();
                                                if (result !=
                                                    ConnectivityResult.none) {
                                                  if (loginState.isLoggined!) {
                                                    if (articleState
                                                        .hiveArticleData!
                                                        .articleLike
                                                        .contains(loginState
                                                            .userUid)) {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'NewArticleCollection')
                                                          .doc(widget.docId)
                                                          .update({
                                                        'NoOfLikes': FieldValue
                                                            .increment(-1),
                                                        "ArticleLike":
                                                            FieldValue
                                                                .arrayRemove([
                                                          loginState.userUid
                                                        ])
                                                      });
                                                    } else {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'NewArticleCollection')
                                                          .doc(widget.docId)
                                                          .update({
                                                        'NoOfLikes': FieldValue
                                                            .increment(1),
                                                        "ArticleLike":
                                                            FieldValue
                                                                .arrayUnion([
                                                          loginState.userUid
                                                        ])
                                                      });
                                                    }
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Check Your Internet Connection'),
                                                  ));
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        context.screenWidth *
                                                            0.001),
                                                width:
                                                    context.screenWidth * 0.07,
                                                height: context.screenHeight *
                                                    0.035,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    loginState.isLoggined!
                                                        ? articleState
                                                                .hiveArticleData!
                                                                .articleLike
                                                                .contains(
                                                                    loginState
                                                                        .userUid)
                                                            ? Icon(
                                                                Icons.favorite)
                                                            : Icon(Icons
                                                                .favorite_border_outlined)
                                                        : Icon(Icons
                                                            .favorite_border_outlined),
                                                    Text(articleState
                                                        .hiveArticleData!
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
                                        horizontal:
                                            context.screenWidth * 0.001),
                                    width: context.screenWidth * 0.35,
                                    height: context.screenWidth * 0.035,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        "Author : ${articleState.hiveArticleData!.authorName}"
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
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.01),
                            BlocBuilder<CheckuserloginedCubit,
                                CheckuserloginedState>(
                              builder: (context, loginState) {
                                return TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            if (commentController
                                                    .text.isNotEmpty &&
                                                commentController
                                                    .text.isNotBlank) {
                                              if (widget.docId != null) {
                                                if (loginState.isLoggined!) {
                                                  CodeArticlesCommentModel
                                                      model =
                                                      CodeArticlesCommentModel(
                                                          commentName:
                                                              loginState.name,
                                                          commentUid: loginState
                                                              .userUid,
                                                          comment:
                                                              commentController
                                                                  .text
                                                                  .trim(),
                                                          timeStamp: FieldValue
                                                              .serverTimestamp(),
                                                          commentTime:
                                                              DateTime.now()
                                                                  .toString());
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'NewArticleCollection')
                                                      .doc(widget.docId)
                                                      .collection('Comments')
                                                      .add(model.toJson())
                                                      .whenComplete(() {
                                                    commentController.clear();
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'NewArticleCollection')
                                                        .doc(widget.docId)
                                                        .update({
                                                      'NoOfComments':
                                                          FieldValue.increment(
                                                              1)
                                                    });
                                                  }).onError(
                                                          (error, stackTrace) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(error
                                                          .toString()
                                                          .split(']')[1]),
                                                    ));
                                                    // ignore: null_argument_to_non_null_type
                                                    return Future.value();
                                                  });
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Please Login into your Account'),
                                                  ));
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Please Enter Comment'),
                                                ));
                                              }
                                            }
                                          },
                                          icon: Icon(Icons.send)),
                                      hintText: "Write Comment Here",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              context.screenSize.aspectRatio *
                                                  7))),
                                );
                              },
                            ),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.01),
                            'Comments'
                                .text
                                .xl3
                                .bold
                                .make()
                                .box
                                .alignCenterLeft
                                .width(context.screenWidth)
                                .height(context.screenHeight * 0.05)
                                .make(),
                            SizedBox(
                                width: context.screenWidth,
                                height: context.screenHeight * 0.01),
                            ValueListenableBuilder<Box<HiveArticlesComments>>(
                              valueListenable:
                                  Boxes.getArticleCommentsFromCloud()
                                      .listenable(),
                              builder: (context, value, child) {
                                listOfComments = List.from(value.values
                                    .sortedByNum((element) =>
                                        DateTime.parse(element.commentTime)
                                            .millisecondsSinceEpoch)
                                    .reversed
                                    .toList()
                                    .cast<HiveArticlesComments>());
                                return listOfComments.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: listOfComments.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              constraints: BoxConstraints(
                                                  minWidth: context.screenWidth,
                                                  maxWidth: context.screenWidth,
                                                  minHeight: context.screenHeight *
                                                      0.15,
                                                  maxHeight: double.infinity),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: context.screenWidth *
                                                      0.01,
                                                  vertical: context.screenHeight *
                                                      0.01),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: context.screenWidth *
                                                      0.01,
                                                  vertical: context.screenHeight *
                                                      0.01),
                                              /*  width: context.screenWidth,
                                              height:
                                                  context.screenHeight * 0.15, */
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          context.screenSize
                                                                  .aspectRatio *
                                                              5)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(listOfComments[index]
                                                          .commentName)
                                                      .text
                                                      .xl
                                                      .semiBold
                                                      .make(),
                                                  Text(readTimestamp(DateTime.parse(
                                                              listOfComments[
                                                                      index]
                                                                  .commentTime)
                                                          .millisecondsSinceEpoch))
                                                      .text
                                                      .light
                                                      .make(),
                                                  SizedBox(
                                                      width:
                                                          context.screenWidth,
                                                      height:
                                                          context.screenHeight *
                                                              0.005),
                                                  Text(listOfComments[index]
                                                          .comment)
                                                      .text
                                                      .lg
                                                      .make(),
                                                ],
                                              ));
                                        },
                                      )
                                    : Text('Be The First One To Comment');
                              },
                            )
                          ])
                    : Center(child: CircularProgressIndicator());
              },
            ).scrollVertical();
          },
        ));
  }
}
