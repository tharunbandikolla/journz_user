// import 'package:firebase_auth/firebase_auth.dart';
// import '/Common/Helper/ThemeBasedWidgetCubit/themebasedwidget_cubit.dart';
// import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
// import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
// import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
// import '/Articles/DataModel/ArticlesModel.dart';
// import '/Common/Constant/Constants.dart';
// import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
// import '/Common/Widgets/HomeBookMarkLikeShare.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:velocity_x/velocity_x.dart';

// class ArticleCard extends StatefulWidget {
//   ArticlesModel model;
//   bool fromReviewAndReject;

//   String docid, title, desc;
//   String? reviewRejectionMessage;
//   ArticleCard({
//     Key? key,
//     this.reviewRejectionMessage,
//     required this.fromReviewAndReject,
//     required this.model,
//     required this.docid,
//     required this.title,
//     required this.desc,
//   }) : super(key: key);

//   @override
//   _ArticleCardState createState() => _ArticleCardState();
// }

// class _ArticleCardState extends State<ArticleCard> {
//   @override
//   Widget build(BuildContext context) {
//     final checkUserLoggedin = BlocProvider.of<CheckuserloginedCubit>(context);

//     checkUserLoggedin.checkLogin();
//     return BlocBuilder<ThemebasedwidgetCubit, ThemebasedwidgetState>(
//       builder: (context, wState) {
//         return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//               Container(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: getWidth(context) * 0.01),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: getWidth(context) * 0.75,
//                           child: Text(
//                             widget.model.articletitle!,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: getWidth(context) * 0.05),
//                           ),
//                         ),
//                         widget.fromReviewAndReject
//                             ? Container()
//                             : BlocBuilder<CheckuserloginedCubit,
//                                 CheckuserloginedState>(
//                                 builder: (context, state) {
//                                   return FirebaseAuth.instance.currentUser !=
//                                           null //state.isLoggined!
//                                       ? widget.model.bookMarkedPeoples!
//                                               .contains(FirebaseAuth
//                                                   .instance.currentUser!.uid)
//                                           ? Icon(Icons.bookmark)
//                                           : Icon(Icons.bookmark_border)
//                                       : Icon(Icons.bookmark_border);
//                                 },
//                               )
//                       ])),
//               SizedBox(
//                 height: getWidth(context) * 0.015,
//               ),
//               Container(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: getWidth(context) * 0.01),
//                 width: getWidth(context) * 0.9,
//                 height: getWidth(context) * 0.135,
//                 child: Text(
//                   widget.model.articledesc!,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: getWidth(context) * 0.048),
//                 ),
//               ),
//               SizedBox(height: context.screenWidth * 0.015),
//               MultiBlocProvider(
//                 providers: [
//                   BlocProvider(create: (context) => ArticlelikeCubit()),
//                   BlocProvider(create: (context) => CommentStreamCubit()),
//                   BlocProvider(
//                       create: (context) => DetailviewdynamiclinkCubit())
//                 ],
//                 child: HomeBookmarkLikeShareTab(
//                   fromReviewAndRejected: widget.fromReviewAndReject,
//                   documentId: widget.docid,
//                   model: widget.model,
//                   title: widget.title,
//                   desc: widget.desc,
//                 ),
//               ),
//               !widget.fromReviewAndReject ? Container() : 15.heightBox,
//               !widget.fromReviewAndReject
//                   ? Container()
//                   : "Review Message - ${widget.reviewRejectionMessage}"
//                       .text
//                       .semiBold
//                       .lg
//                       .make()
//             ])
//             .box
//             .p8
//             .customRounded(BorderRadius.all(Radius.circular(15)))
//             .width(context.screenWidth)
//             .height(widget.fromReviewAndReject
//                 ? context.screenWidth * 0.57
//                 : context.screenWidth * 0.37)
//             .neumorphic(
//               elevation: 30,
//               color: wState.isLightTheme ? Colors.white : Colors.black,
//             )
//             .make();
//       },
//     ).box.makeCentered();
//   }
// }
