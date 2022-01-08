import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journz_web/HiveArticlesModel/ArticleModel/hive_article_data.dart';
import 'package:journz_web/NewHomePage/Cubits/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class OldHomePageCenterPaneArticleCard extends StatefulWidget {
  final List<HiveArticleData> listOfArticles;
  final int index;
  const OldHomePageCenterPaneArticleCard(
      {Key? key, required this.index, required this.listOfArticles})
      : super(key: key);

  @override
  _OldHomePageCenterPaneArticleCardState createState() =>
      _OldHomePageCenterPaneArticleCardState();
}

class _OldHomePageCenterPaneArticleCardState
    extends State<OldHomePageCenterPaneArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.white, width: context.screenHeight * 0.003),
          borderRadius: BorderRadius.circular(context.screenHeight * 0.02)),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.005,
            vertical: context.screenHeight * 0.01),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(context.screenHeight * 0.02)),
        height: context.screenHeight * 0.05,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.listOfArticles[widget.index].articleTitle!,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: context.screenHeight * 0.025)),
            Html(
                    data: widget.listOfArticles[widget.index].articleDescription
                            .substring(0, 35) +
                        "...")
                .box
                .height(context.screenHeight * 0.1)
                .make(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.001,
                      vertical: context.screenHeight * 0.003),
                  width: context.screenWidth * 0.1,
                  color: Colors.grey.shade300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.commentDots),
                      Text(widget.listOfArticles[widget.index].noOfComments
                          .toString()),
                      Text('Comments')
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.001,
                      vertical: context.screenHeight * 0.003),
                  width: context.screenWidth * 0.075,
                  color: Colors.grey.shade300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                        builder: (context, loginState) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth * 0.001),
                            width: context.screenWidth * 0.07,
                            height: context.screenHeight * 0.035,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                loginState.isLoggined!
                                    ? widget.listOfArticles[widget.index]
                                            .articleLike
                                            .contains(FirebaseAuth
                                                .instance.currentUser!.uid)
                                        ? Icon(Icons.favorite)
                                        : Icon(Icons.favorite_border_outlined)
                                    : Icon(Icons.favorite_border_outlined),
                                Text(widget
                                    .listOfArticles[widget.index].noOflikes
                                    .toString()),
                                Text('Likes')
                              ],
                            ),
                          );
                        },
                      ),
                      /*   Text(widget.listOfArticles[widget.index].noOflikes
                          .toString()), */
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.001,
                      vertical: context.screenHeight * 0.003),
                  width: context.screenWidth * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.share),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
