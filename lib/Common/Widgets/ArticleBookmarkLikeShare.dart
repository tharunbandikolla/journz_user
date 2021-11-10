// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:share/share.dart';
// import '/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
// import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
// import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
// import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
// import '/ArticleDetailView/DataService/ArticlesDetailViewDB.dart';
// import '/Articles/DataModel/ArticlesModel.dart';
// import '/Authentication/Screens/VerifyEmail.dart';
// import '/Common/Constant/Constants.dart';
// import '/UserProfile/Screen/UserNotLoggedInScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:velocity_x/velocity_x.dart';

// class BookmarkLikeShareTab extends StatefulWidget {
//   String documentId;
//   String title, desc, authorName;
//   ArticlesModel? model;
//   BookmarkLikeShareTab(
//       {Key? key,
//       required this.documentId,
//       required this.title,
//       this.model,
//       required this.authorName,
//       required this.desc})
//       : super(key: key);

//   @override
//   _BookmarkLikeShareTabState createState() => _BookmarkLikeShareTabState();
// }

// class _BookmarkLikeShareTabState extends State<BookmarkLikeShareTab> {
//   late String name;

//   String commentCount = '0';
//   @override
//   void initState() {
//     if (FirebaseAuth.instance.currentUser != null) {
//       ArticleDetailViewDB()
//           .commentPersonName(FirebaseAuth.instance.currentUser!.uid)
//           .then((value) {
//         name = value.data()!['Name'];
//       });
//     } else {
//       name = '';
//     }

//     super.initState();
//   }

//   doThisOnLaunch() async {
//     print('nnn im working');
//     FirebaseFirestore.instance
//         .collection('ArticlesCollection')
//         .doc(widget.documentId)
//         .snapshots()
//         .listen((event) async {
//       commentCount = await event.data()!['NoOfComment'];
//       print('nnn comment $commentCount');
//     });

//     //await ArticleDetailViewDB()
//     //  .commentCountFunc(widget.documentId)
//     //  .then((value) async {
//     // commentCount = await value.data()!['NoOfComment'];
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<ArticlelikeCubit>(context);
//     cubit.getInitialstate(widget.documentId);

//     final shareCubit = BlocProvider.of<DetailviewdynamiclinkCubit>(context);
//     final bookmarkCubit = BlocProvider.of<BookmarkCubit>(context);
//     if (FirebaseAuth.instance.currentUser?.uid != null) {
//       bookmarkCubit.checkBookmarked(
//           FirebaseAuth.instance.currentUser!.uid, widget.documentId);
//     }

//     return widget.model!.isArticlePublished! == "Published"
//         ? Container(
//             padding: EdgeInsets.symmetric(horizontal: getWidth(context) * 0.01),
//             width: getWidth(context) * 0.99,
//             height: getWidth(context) * 0.1,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   InkWell(
//                       onTap: () {
//                         /*        Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => MultiBlocProvider(
//                                       providers: [
//                                         BlocProvider(
//                                             create: (context) =>
//                                                 CheckuserloginedCubit()),
//                                         BlocProvider(
//                                             create: (context) =>
//                                                 CommentStreamCubit()),
//                                       ],
//                                       child: ArticleCommentScreen(
//                                         documentId: widget.documentId,
//                                         name: name,
//                                       ),
//                                     )));*/
//                       },
//                       child: Container(
//                           width: getWidth(context) * 0.4,
//                           height: getWidth(context) * 0.1,
//                           decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Icon(
//                                   FontAwesomeIcons.solidCommentDots,
//                                   color: Colors.black,
//                                 ),
//                                 /*          BlocBuilder<CommentStreamCubit, CommentCubitState>(
//                   builder: (context, state) {
//                     return */
//                                 BlocBuilder<CommentnumbersCubit,
//                                     CommentnumbersState>(
//                                   builder: (context, cState) {
//                                     print(
//                                         'nnn no of cState ${cState.noOfComment}');
//                                     return Text(
//                                             '${cState.noOfComment} Comments')
//                                         .text
//                                         .black
//                                         .makeCentered();
//                                   },
//                                 )
//                               ]))

//                       /*Container(
//               width: getWidth(context) * 0.4,
//               height: getWidth(context) * 0.1,
//               color: Colors.grey,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(FontAwesomeIcons.solidCommentDots),
//                   BlocBuilder<CommentStreamCubit, CommentCubitState>(
//                     builder: (context, state) {
//                       return Text(
//                           '${state.noOfComment == null ? 0 : state.noOfComment} Comments');
//                     },
//                   )
//                 ],
//               ),
//             ),*/
//                       ),
//                   BlocBuilder<ArticlelikeCubit, ArticlelikeState>(
//                     builder: (context, state) {
//                       print('nnn like state ${state.isLiked} ');
//                       return Container(
//                         alignment: Alignment.center,
//                         width: getWidth(context) * 0.2,
//                         height: getWidth(context) * 0.1,
//                         color: Colors.grey[300],
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   if (FirebaseAuth.instance.currentUser?.uid !=
//                                       null) {
//                                     if (FirebaseAuth
//                                         .instance.currentUser!.emailVerified) {
//                                       state.isLiked!
//                                           ? cubit
//                                               .disLikeArticle(widget.documentId)
//                                           : cubit
//                                               .likedArticle(widget.documentId);
//                                     } else {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   VerifyEmailScreen()));
//                                     }
//                                   } else {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 UserNotLoggedInScreen()));
//                                   }
//                                 },
//                                 icon: state.isLiked!
//                                     ? Icon(
//                                         Icons.favorite,
//                                         color: Colors.black,
//                                       )
//                                     : Icon(
//                                         Icons.favorite_outline,
//                                         color: Colors.black,
//                                       )),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(widget.model!.noOfLike!.toString()
//                                       //state.noOfLike.toString(),
//                                       )
//                                   .text
//                                   .black
//                                   .makeCentered(),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   IconButton(
//                       icon: Icon(Icons.share),
//                       onPressed: () {
//                         /*  shareCubit.createDynamicLink(true, widget.documentId,
//                             widget.title, '/Articles', widget.desc); */
//                         Share.share(widget.model!.socialMediaLink!.trim());
//                       })
//                 ]))
//         : Container();
//   }
// }
