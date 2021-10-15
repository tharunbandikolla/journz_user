import 'package:firebase_auth/firebase_auth.dart';
import 'package:share/share.dart';
import 'package:velocity_x/velocity_x.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/Articles/DataModel/ArticlesModel.dart';
import '/Common/Constant/Constants.dart';
import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeBookmarkLikeShareTab extends StatefulWidget {
  bool fromReviewAndRejected;
  String documentId, title, desc;
  ArticlesModel model;
  HomeBookmarkLikeShareTab(
      {Key? key,
      required this.fromReviewAndRejected,
      required this.model,
      required this.documentId,
      required this.title,
      required this.desc})
      : super(key: key);

  @override
  _HomeBookmarkLikeShareTabState createState() =>
      _HomeBookmarkLikeShareTabState();
}

class _HomeBookmarkLikeShareTabState extends State<HomeBookmarkLikeShareTab> {
  @override
  Widget build(BuildContext context) {
    //final cubit = BlocProvider.of<ArticlelikeCubit>(context);
    //  cubit.getInitialstate(widget.documentId);
    final checkUserLoggedIn = BlocProvider.of<CheckuserloginedCubit>(context);
    checkUserLoggedIn.checkLogin();
    final dynamicLinkCubit =
        BlocProvider.of<DetailviewdynamiclinkCubit>(context);
    //final commentCubit = BlocProvider.of<CommentStreamCubit>(context);
//    commentCubit.getStream(widget.documentId);
    return Container(
        //color: Colors.amber,
        //padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.01),
        width: getWidth(context),
        height: getWidth(context) * 0.08,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: getWidth(context) * 0.4,
            height: getWidth(context) * 0.1,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  FontAwesomeIcons.solidCommentDots,
                  color: Colors.black,
                  size: 20,
                ),
                /*          BlocBuilder<CommentStreamCubit, CommentCubitState>(
                  builder: (context, state) {
                    return */
                Text('${widget.model.noOfComment} Comments')
                    .text
                    .black
                    .makeCentered(),
                //state.noOfComment == null ? 0 : state.noOfComment
                /*},
                )*/
              ],
            ),
          ),
          //pIcon(Icons.bookmark_border),
          /* BlocBuilder<ArticlelikeCubit, ArticlelikeState>(
            builder: (context, state) {
              print('nnn like state ${state.isLiked} ${state.noOfLike}');
              return */
          Container(
            alignment: Alignment.center,
            width: getWidth(context) * 0.2,
            height: getWidth(context) * 0.08,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<CheckuserloginedCubit, CheckuserloginedState>(
                  builder: (context, state) {
                    return state.isLoggined!
                        ? widget.model.peopleLike!.contains(
                                FirebaseAuth.instance.currentUser!.uid)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.black,
                                size: 20,
                              )
                            : Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.black,
                                size: 20,
                              )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.black,
                            size: 20,
                          );
                  },
                ),
                //  IconButton(
                //    onPressed: () {
                /*              state.isLiked!
                              ? widget.cubit.disLikeArticle(widget.documentId)
                              : widget.cubit.likedArticle(widget.documentId);*/
                //  },
                /*  state.isLiked!
                        ? Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          )
                        : Icon(Icons.favorite_outline),*/
                Text(
                  widget.model.noOfLike!,
                ).text.black.makeCentered(),
              ],
            ),
            /*  );
            },*/
          ),
          widget.fromReviewAndRejected
              ? Container()
              : IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    /*  dynamicLinkCubit.createDynamicLink(true, widget.documentId,
                    widget.title, '/Articles', widget.desc); */
                    Share.share(widget.model.socialMediaLink!.trim());
                  })
        ]));
  }
}
