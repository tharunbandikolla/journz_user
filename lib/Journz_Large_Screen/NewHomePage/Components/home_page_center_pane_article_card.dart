import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import '/Journz_Large_Screen/HiveArticlesModel/LocalArticleModel/code_article_model.dart';
import '/Journz_Large_Screen/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageCenterPaneArticleCard extends StatefulWidget {
  final /* List<HiveArticleData> */ CodeArticleData listOfArticles;

  final int index;
  const HomePageCenterPaneArticleCard(
      {Key? key, required this.index, required this.listOfArticles})
      : super(key: key);

  @override
  _HomePageCenterPaneArticleCardState createState() =>
      _HomePageCenterPaneArticleCardState();
}

class _HomePageCenterPaneArticleCardState
    extends State<HomePageCenterPaneArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.005,
          vertical: context.screenHeight * 0.01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.screenHeight * 0.02)),
      height: context.screenHeight * 0.2,
      //width: context.screenWidth,
      child: Row(
        children: [
          widget.index.isEven
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon_eye.png',
                          color: Colors.black,
                        )
                            .box
                            .width(context.screenWidth * 0.02)
                            .height(context.screenHeight * 0.035)
                            .make(),
                        widget.listOfArticles.noOfViews! >= 1000 &&
                                widget.listOfArticles.noOfViews! <= 999999
                            ? Text((widget.listOfArticles.noOfViews! / 1000)
                                    .floor()
                                    .toString() +
                                "K")
                            : widget.listOfArticles.noOfViews! >= 1000000 &&
                                    widget.listOfArticles.noOfViews! <=
                                        999999999
                                ? Text(
                                    (widget.listOfArticles.noOfViews! / 1000000)
                                            .floor()
                                            .toString() +
                                        "M")
                                : Text(
                                    widget.listOfArticles.noOfViews.toString()),
                      ],
                    ).box.width(context.screenWidth * 0.045).make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icon_new_chat.png',
                                color: Colors.black)
                            .box
                            .width(context.screenWidth * 0.02)
                            .height(context.screenHeight * 0.035)
                            .make(),
                        widget.listOfArticles.noOfComments! >= 1000 &&
                                widget.listOfArticles.noOfComments! <= 999999
                            ? Text((widget.listOfArticles.noOfComments! / 1000)
                                    .floor()
                                    .toString() +
                                "K")
                            : widget.listOfArticles.noOfComments! >= 1000000 &&
                                    widget.listOfArticles.noOfComments! <=
                                        999999999
                                ? Text((widget.listOfArticles.noOfComments! /
                                            1000000)
                                        .floor()
                                        .toString() +
                                    "M")
                                : Text(widget.listOfArticles.noOfComments
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
                                ? widget.listOfArticles.articleLike!.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Image.asset('assets/images/Okay2.png',
                                            color: Colors.black)
                                        .box
                                        .width(context.screenWidth * 0.02)
                                        .height(context.screenHeight * 0.035)
                                        .make()
                                    : Image.asset(
                                            'assets/images/Okayoutline1.png',
                                            color: Colors.black)
                                        .box
                                        .width(context.screenWidth * 0.02)
                                        .height(context.screenHeight * 0.035)
                                        .make()
                                : Image.asset('assets/images/Okayoutline1.png',
                                        color: Colors.black)
                                    .box
                                    .width(context.screenWidth * 0.02)
                                    .height(context.screenHeight * 0.035)
                                    .make(),

                            widget.listOfArticles.noOflikes! >= 1000 &&
                                    widget.listOfArticles.noOflikes! <= 999999
                                ? Text((widget.listOfArticles.noOflikes! / 1000)
                                        .floor()
                                        .toString() +
                                    "K")
                                : widget.listOfArticles.noOflikes! >= 1000000 &&
                                        widget.listOfArticles.noOflikes! <=
                                            999999999
                                    ? Text((widget.listOfArticles.noOflikes! /
                                                1000000)
                                            .floor()
                                            .toString() +
                                        "M")
                                    : Text(widget.listOfArticles.noOflikes
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
                        Image.asset('assets/images/icon_new_share.png',
                                color: Colors.black)
                            .box
                            .width(context.screenWidth * 0.02)
                            .height(context.screenHeight * 0.035)
                            .make(),
                      ],
                    ).box.width(context.screenWidth * 0.045).make()
                  ],
                )
                  .box
                  .height(context.screenHeight * 0.3)
                  .make() //.box.width(context.screenWidth * 0.045).make()
              : Container(),
          widget.index.isEven
              ? VerticalDivider(
                  thickness: context.screenSize.aspectRatio,
                  color: Colors.black12)
              : Container(),
          widget.listOfArticles.articlePhotoUrl != 'WithoutImage'
              ? widget.index.isEven
                  ? Image.network(widget.listOfArticles.articlePhotoUrl!,
                          fit: BoxFit.fill)
                      .box
                      .height(context.screenHeight * 0.2)
                      .width(context.screenWidth * 0.1)
                      .make()
                  : Container()
              : Container(),
          SizedBox(width: context.screenWidth * 0.005),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.listOfArticles.articleTitle!,
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: context.screenHeight * 0.025))
              /* .box
                  .height(context.screenWidth * 0.035)
                  .width(context.screenWidth * 0.395)
                  .make() */
              ,
              Text(widget.listOfArticles.articleDescription!
                      .split(RegExp("<(“[^”]*”|'[^’]*’|[^'”>])*>"))
                      .join("")
                      .split(".")
                      .join(".\n")
                      .substring(
                          0,
                          widget.listOfArticles.articlePhotoUrl !=
                                  'WithoutImage'
                              ? 150
                              : 180) +
                  "..."),
            ],
          )
              .box
              .width(widget.listOfArticles.articlePhotoUrl != 'WithoutImage'
                  ? context.screenWidth * 0.275
                  : context.screenWidth * 0.365)
              .make(),
          widget.listOfArticles.articlePhotoUrl != 'WithoutImage'
              ? widget.index.isOdd
                  ? Image.network(widget.listOfArticles.articlePhotoUrl!,
                          fit: BoxFit.fill)
                      .box
                      .height(context.screenHeight * 0.2)
                      .width(context.screenWidth * 0.1)
                      .make()
                  : Container()
              : Container(),
          widget.index.isOdd
              ? VerticalDivider(
                  thickness: context.screenSize.aspectRatio,
                  color: Colors.black12)
              : Container(),
          widget.index.isOdd
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon_eye.png',
                          color: Colors.black,
                        )
                            .box
                            .width(context.screenWidth * 0.02)
                            .height(context.screenHeight * 0.035)
                            .make(),
                        widget.listOfArticles.noOfViews! >= 1000 &&
                                widget.listOfArticles.noOfViews! <= 999999
                            ? Text((widget.listOfArticles.noOfViews! / 1000)
                                    .floor()
                                    .toString() +
                                "K")
                            : widget.listOfArticles.noOfViews! >= 1000000 &&
                                    widget.listOfArticles.noOfViews! <=
                                        999999999
                                ? Text(
                                    (widget.listOfArticles.noOfViews! / 1000000)
                                            .floor()
                                            .toString() +
                                        "M")
                                : Text(
                                    widget.listOfArticles.noOfViews.toString()),
                      ],
                    ).box.width(context.screenWidth * 0.045).make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon_new_chat.png',
                          color: Colors.black,
                        )
                            .box
                            .width(context.screenWidth * 0.02)
                            .height(context.screenHeight * 0.035)
                            .make(),
                        widget.listOfArticles.noOfComments! >= 1000 &&
                                widget.listOfArticles.noOfComments! <= 999999
                            ? Text((widget.listOfArticles.noOfComments! / 1000)
                                    .floor()
                                    .toString() +
                                "K")
                            : widget.listOfArticles.noOfComments! >= 1000000 &&
                                    widget.listOfArticles.noOfComments! <=
                                        999999999
                                ? Text((widget.listOfArticles.noOfComments! /
                                            1000000)
                                        .floor()
                                        .toString() +
                                    "M")
                                : Text(widget.listOfArticles.noOfComments
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
                                ? widget.listOfArticles.articleLike!
                                        .contains(loginState.userUid)
                                    ? Image.asset(
                                        'assets/images/Okay2.png',
                                        color: Colors.black,
                                      )
                                        .box
                                        .width(context.screenWidth * 0.02)
                                        .height(context.screenHeight * 0.035)
                                        .make()
                                    : Image.asset(
                                            'assets/images/Okayoutline1.png',
                                            color: Colors.black)
                                        .box
                                        .width(context.screenWidth * 0.02)
                                        .height(context.screenHeight * 0.035)
                                        .make()
                                : Image.asset('assets/images/Okayoutline1.png',
                                        color: Colors.black)
                                    .box
                                    .width(context.screenWidth * 0.02)
                                    .height(context.screenHeight * 0.035)
                                    .make(),
                            widget.listOfArticles.noOflikes! >= 1000 &&
                                    widget.listOfArticles.noOflikes! <= 999999
                                ? Text((widget.listOfArticles.noOflikes! / 1000)
                                        .floor()
                                        .toString() +
                                    "K")
                                : widget.listOfArticles.noOflikes! >= 1000000 &&
                                        widget.listOfArticles.noOflikes! <=
                                            999999999
                                    ? Text((widget.listOfArticles.noOflikes! /
                                                1000000)
                                            .floor()
                                            .toString() +
                                        "M")
                                    : Text(widget.listOfArticles.noOflikes
                                        .toString()),
                          ],
                        ).box.width(context.screenWidth * 0.045).make();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icon_new_share.png',
                                color: Colors.black)
                            .box
                            .width(context.screenWidth * 0.02)
                            .height(context.screenHeight * 0.035)
                            .make(),
                      ],
                    ).box.width(context.screenWidth * 0.045).make()
                  ],
                ).box.height(context.screenHeight * 0.3).make()
              : Container(),
        ],
      ),
    )
        .box
        .border(color: Colors.white, width: 3)
        .customRounded(BorderRadius.circular(12))
        .neumorphic(
          elevation: 16,
          color: Colors.white,
        )
        .make() /*) */;
  }
}
