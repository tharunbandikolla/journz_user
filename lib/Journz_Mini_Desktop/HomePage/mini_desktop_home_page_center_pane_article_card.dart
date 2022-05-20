import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class MiniDeskHomePageCenterPaneArticleCard extends StatefulWidget {
  final List<HiveArticleData> listOfArticles;
  final int index;
  const MiniDeskHomePageCenterPaneArticleCard(
      {Key? key, required this.index, required this.listOfArticles})
      : super(key: key);

  @override
  _HomePageCenterPaneArticleCardState createState() =>
      _HomePageCenterPaneArticleCardState();
}

class _HomePageCenterPaneArticleCardState
    extends State<MiniDeskHomePageCenterPaneArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.005,
          vertical: context.screenHeight * 0.01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.screenHeight * 0.02)),
      height: context.screenHeight * 0.24,
      //width: context.screenWidth,
      child: Container(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            widget.index.isEven
                ?
                /* Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Diamond2.png',
                            color: Colors.blue.shade400,
                          )
                              .box
                              .width(context.screenWidth * 0.02)
                              .height(context.screenHeight * 0.035)
                              .make(),
                          Text(widget.listOfArticles[widget.index].noOfViews
                              .toString()),
                        ],
                      ).box.width(context.screenWidth * 0.045).make(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Chat2.png',
                                  color: Colors.blue.shade400)
                              .box
                              .width(context.screenWidth * 0.02)
                              .height(context.screenHeight * 0.035)
                              .make(),
                          Text(widget.listOfArticles[widget.index].noOfComments
                              .toString()),
                        ],
                      ).box.width(context.screenWidth * 0.045).make(),
                      BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                        builder: (context, loginState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              loginState.isLoggined!
                                  ? widget.listOfArticles[widget.index]
                                          .articleLike
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? Image.asset('assets/images/Okay2.png',
                                              color: Colors.blue.shade400)
                                          .box
                                          .width(context.screenWidth * 0.02)
                                          .height(context.screenHeight * 0.035)
                                          .make()
                                      : Image.asset(
                                              'assets/images/Okayoutline1.png',
                                              color: Colors.blue.shade400)
                                          .box
                                          .width(context.screenWidth * 0.02)
                                          .height(context.screenHeight * 0.035)
                                          .make()
                                  : Image.asset('assets/images/Okayoutline1.png',
                                          color: Colors.blue.shade400)
                                      .box
                                      .width(context.screenWidth * 0.02)
                                      .height(context.screenHeight * 0.035)
                                      .make(),
                              Text(widget.listOfArticles[widget.index].noOflikes
                                  .toString()),
                              //  Text('Likes')
                            ],
                          ).box.width(context.screenWidth * 0.045).make();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Sharefilled2.png',
                                  color: Colors.blue.shade400)
                              .box
                              .width(context.screenWidth * 0.02)
                              .height(context.screenHeight * 0.035)
                              .make(),
                        ],
                      ).box.width(context.screenWidth * 0.045).make()
                    ],
                  ).box.width(context.screenWidth * 0.045).make()*/
                postsocial(widget.listOfArticles, widget.index)
                : Container(),
            widget.index.isEven
                ? VerticalDivider(
                    thickness: context.screenSize.aspectRatio,
                    color: Colors.black12)
                : Container(),
            widget.listOfArticles[widget.index].articlePhotoUrl !=
                    'WithoutImage'
                ? widget.index.isEven
                    ?
                    /*Image.network(
                            widget.listOfArticles[widget.index].articlePhotoUrl,
                            fit: BoxFit.fill)
                        .box
                        .height(context.screenHeight * 0.2)
                        .width(context.screenWidth * 0.1)
                        .make()*/
                    postimage(
                        widget.listOfArticles[widget.index].articlePhotoUrl)
                    : Container()
                : Container(),
            // SizedBox(width: context.screenWidth * 0.005),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(

                    widget.listOfArticles[widget.index].articleTitle!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: context.screenHeight * 0.024)),

                Html(
                        data: widget
                                .listOfArticles[widget.index].articleDescription
                                .split(RegExp("<(“[^”]*”|'[^’]*’|[^'”>])*>"))
                                .join("")
                                .substring(
                                    0,
                                    widget.listOfArticles[widget.index]
                                                .articlePhotoUrl !=
                                            'WithoutImage'
                                        ? 150
                                        : 210) +
                            "...")
                    .box
                    .height(context.screenHeight * 0.1)
                    .width(context.screenWidth * 0.365)
                    .make(),
              ],
            )
                .box
                .width(widget.listOfArticles[widget.index].articlePhotoUrl !=
                        'WithoutImage'
                    ? context.screenWidth * 0.275
                    : context.screenWidth * 0.365)
                .make(),*/
            postcontent(widget.listOfArticles, widget.index),
            widget.listOfArticles[widget.index].articlePhotoUrl !=
                    'WithoutImage'
                ? widget.index.isOdd
                    ?
                    /*Image.network(
                            widget.listOfArticles[widget.index].articlePhotoUrl,
                            fit: BoxFit.fill)
                        .box
                        .height(context.screenHeight * 0.2)
                        .width(context.screenWidth * 0.1)
                        .make()*/
                    postimage(
                        widget.listOfArticles[widget.index].articlePhotoUrl)
                    : Container()
                : Container(),
            // SizedBox(width: context.screenWidth * 0.005),
            widget.index.isOdd
                ? VerticalDivider(
                    thickness: context.screenSize.aspectRatio,
                    color: Colors.black12)
                : Container(),
            widget.index.isOdd
                ?
                /* Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Diamondcare.png',
                            color: Colors.blue.shade400,
                          )
                              .box
                              .width(context.screenWidth * 0.02)
                              .height(context.screenHeight * 0.035)
                              .make(),
                          Text(widget.listOfArticles[widget.index].noOfViews
                              .toString()),
                        ],
                      ).box.width(context.screenWidth * 0.045).make(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Chat2.png',
                            color: Colors.blue.shade400,
                          )
                              .box
                              .width(context.screenWidth * 0.02)
                              .height(context.screenHeight * 0.035)
                              .make(),
                          Text(widget.listOfArticles[widget.index].noOfComments
                              .toString()),
                        ],
                      ).box.width(context.screenWidth * 0.045).make(),
                      BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                        builder: (context, loginState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              loginState.isLoggined!
                                  ? widget.listOfArticles[widget.index]
                                          .articleLike
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? Image.asset(
                                          'assets/images/Okay2.png',
                                          color: Colors.blue.shade400,
                                        )
                                          .box
                                          .width(context.screenWidth * 0.02)
                                          .height(context.screenHeight * 0.035)
                                          .make()
                                      : Image.asset(
                                              'assets/images/Okayoutline1.png',
                                              color: Colors.blue.shade400)
                                          .box
                                          .width(context.screenWidth * 0.02)
                                          .height(context.screenHeight * 0.035)
                                          .make()
                                  : Image.asset('assets/images/Okayoutline1.png',
                                          color: Colors.blue.shade400)
                                      .box
                                      .width(context.screenWidth * 0.02)
                                      .height(context.screenHeight * 0.035)
                                      .make(),
                              Text(widget.listOfArticles[widget.index].noOflikes
                                  .toString()),
                            ],
                          ).box.width(context.screenWidth * 0.045).make();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Sharefilled2.png',
                                  color: Colors.blue.shade400)
                              .box
                              .width(context.screenWidth * 0.02)
                              .height(context.screenHeight * 0.035)
                              .make(),
                        ],
                      ).box.width(context.screenWidth * 0.045).make()
                    ],
                  )*/
                postsocial(widget.listOfArticles, widget.index)
                : Container(),
          ],
        ),
      ),
    )
        .box
        .border(color: Colors.white, width: 3)
        .customRounded(BorderRadius.circular(10))
        .neumorphic(
          elevation: 10,
          color: Colors.white,
        )
        .make() /*) */;
  }
}

Widget postsocial(List<HiveArticleData> listOfArticles, int index) {
  var width = 22.0;
  return Builder(builder: (context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon_eye.png',
              color: Colors.black,
            ).box.width(width).height(width).make(),
            Text(listOfArticles[index].noOfViews.toString()),
          ],
        ).box.width(55).make(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon_new_chat.png',
              color: Colors.black,
            ).box.width(width).height(width).make(),
            Text(listOfArticles[index].noOfComments.toString()),
          ],
        ).box.width(55).make(),
        BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
          builder: (context, loginState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loginState.isLoggined!
                    ? listOfArticles[index]
                            .articleLike
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? Image.asset(
                            'assets/images/icon_heart_filled.png',
                            color: Colors.black,
                          ).box.width(width).height(width).make()
                        : Image.asset('assets/images/icon_heart_outline.png',
                                color: Colors.black)
                            .box
                            .width(width)
                            .height(width)
                            .make()
                    : Image.asset('assets/images/icon_heart_outline.png',
                            color: Colors.black)
                        .box
                        .width(width)
                        .height(width)
                        .make(),
                Text(listOfArticles[index].noOflikes.toString()),
              ],
            ).box.width(55).make();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon_new_share.png', color: Colors.black)
                .box
                .width(width)
                .height(width)
                .make(),
          ],
        ).box.width(55).make()
      ],
    ).box.width(60).make();
  });
}

Widget postcontent(List<HiveArticleData> listOfArticles, int index) {
  return Builder(
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(listOfArticles[index].articleTitle!,
              maxLines: 2,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: context.screenHeight * 0.024)),
          Text(listOfArticles[index]
                  .articleDescription
                  .split(RegExp("<(“[^”]*”|'[^’]*’|[^'”>])*>"))
                  .join("")
                  .substring(
                      0,
                      listOfArticles[index].articlePhotoUrl != 'WithoutImage'
                          ? 150
                          : 210) +
              "...")
          /*  .box
              .height(context.screenHeight * 0.1)
              .width(context.screenWidth * 0.35)
              .make() */
          ,
        ],
      )
          .box
          .width(listOfArticles[index].articlePhotoUrl != 'WithoutImage'
              ? context.screenWidth * 0.4
              : context.screenWidth * 0.50)
          .make();
    },
  );
}

Widget postimage(String articlePhotoUrl) {
  return Builder(builder: (context) {
    return Image.network(articlePhotoUrl,
            //fit: BoxFit.fill
            fit: BoxFit.cover)
        .box
        .height(context.screenHeight * 0.2)
        .width(context.screenWidth * 0.13)
        .make();
  });
}
