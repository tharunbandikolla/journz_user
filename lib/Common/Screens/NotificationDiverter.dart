import 'dart:async';
import 'package:Journz/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';

import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';

import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/ArticleDetailView/Screen/ArticleDetaillViewScreen.dart';
import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationDiverter extends StatefulWidget {
  NotificationDiverter({Key? key}) : super(key: key);

  @override
  _NotificationDiverterState createState() => _NotificationDiverterState();
}

class _NotificationDiverterState extends State<NotificationDiverter> {
  //late Timer t;

  @override
  Widget build(BuildContext context) {
    var postId;
    postId = ModalRoute.of(context)!.settings.arguments;
    delayedNavigator(postId, context);
    //  print('linkpastid $postId');

/*    t = Timer(Duration(microseconds: 2500), () {
      if (postId != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                            create: (context) => ArticlesdetailCubit()),
                        BlocProvider(create: (context) => ArticlelikeCubit()),
                        BlocProvider(create: (context) => ArticlereportCubit()),
                        BlocProvider(
                            create: (context) => DetailviewdynamiclinkCubit()),
                        BlocProvider(create: (context) => CommentStreamCubit()),
                        BlocProvider(create: (context) => ArticletitleCubit()),
                        BlocProvider(create: (context) => BookmarkCubit()),
                      ],
                      child: ArticlesDetailViewScreen(
                        documentId: postId,
                        fromNotification: true,
                      ),
                    )),
            (route) => false);
      }
    });
*/
    return Scaffold(
        body: Container(
      width: getWidth(context),
      height: getHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: getWidth(context) * 0.05,
          ),
          Text('Redirecting...')
        ],
      ),
    ));
  }

  delayedNavigator(String? postId, BuildContext context) {
    Future.delayed(Duration(milliseconds: 2500), () {
      print('linkpath delayed initiated');
      if (postId != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                            create: (context) => DetailviewdynamiclinkCubit()),
                        BlocProvider(create: (context) => ArticlelikeCubit()),
                        BlocProvider(create: (context) => BookmarkCubit()),
                        BlocProvider(
                            create: (context) => ArticlesdetailCubit()),
                        BlocProvider(create: (context) => ArticlelikeCubit()),
                        BlocProvider(
                            create: (context) => CheckuserloginedCubit()),
                        BlocProvider(
                            create: (context) => DetailviewdynamiclinkCubit()),
                        BlocProvider(create: (context) => CommentStreamCubit()),
                        BlocProvider(create: (context) => ArticletitleCubit()),
                        BlocProvider(
                            create: (context) => CommentnumbersCubit()),
                        BlocProvider(create: (context) => ArticlereportCubit()),
                        BlocProvider(create: (context) => BookmarkCubit())
                      ],
                      child: ArticlesDetailViewScreen(
                        title: null,
                        documentId: postId,
                        fromReviewOrReject: false,
                        fromNotification: true,
                        fromEdit: false,
                      ),
                    )),
            (route) => false);
      }
    });
  }

  @override
  void dispose() {
    //  t.cancel();
    super.dispose();
  }
}
