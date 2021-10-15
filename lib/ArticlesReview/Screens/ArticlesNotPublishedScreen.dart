import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/ArticleDetailView/Screen/ArticleDetaillViewScreen.dart';
import '/ArticlesReview/Cubit/cubit/Reviewarticlestream_cubit.dart';
import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlesNotPubishedScreen extends StatefulWidget {
  const ArticlesNotPubishedScreen({Key? key}) : super(key: key);

  @override
  _ArticlesNotPubishedScreenState createState() =>
      _ArticlesNotPubishedScreenState();
}

class _ArticlesNotPubishedScreenState extends State<ArticlesNotPubishedScreen> {
  @override
  void initState() {
    context.read<ReviewarticlestreamCubit>().getPostedArticleStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Articles Not Published'.text.bold.make(),
      ),
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        child: BlocBuilder<ReviewarticlestreamCubit, ReviewarticlestreamState>(
          builder: (context, sState) {
            return StreamBuilder(
              stream: sState.postedArticleStream,
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return snapshot.data.docs[index]
                                      ['IsArticlePublished'] ==
                                  "NotPublished"
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                        create: (context) =>
                                                            ArticlesdetailCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            ArticlelikeCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            DetailviewdynamiclinkCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            CommentStreamCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            ArticletitleCubit()),
                                                    BlocProvider(
                                                      create: (context) =>
                                                          ArticlereportCubit(),
                                                    ),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            BookmarkCubit()),
                                                  ],
                                                  child:
                                                      ArticlesDetailViewScreen(
                                                    title: snapshot
                                                            .data.docs[index]
                                                        ['ArticleTitle'],
                                                    fromReviewOrReject: true,
                                                    documentId: snapshot
                                                        .data.docs[index].id,
                                                    fromNotification: false,
                                                    fromEdit: false,
                                                  ),
                                                )));
                                  },
                                  child: VStack([
                                    VStack([
                                      Text(snapshot.data.docs[index]
                                              ['ArticleTitle'])
                                          .text
                                          .bold
                                          .ellipsis
                                          .xl
                                          .make(),
                                      15.heightBox,
                                      Text(snapshot.data.docs[index]
                                              ['ArticleDescription'])
                                          .text
                                          .lg
                                          .maxLines(2)
                                          .ellipsis
                                          .make(),
                                      5.heightBox,
                                    ], alignment: MainAxisAlignment.spaceEvenly)
                                        .box
                                        .p12
                                        .margin(EdgeInsets.symmetric(
                                            horizontal:
                                                getWidth(context) * 0.03,
                                            vertical:
                                                getWidth(context) * 0.015))
                                        .make(),
                                    Divider(
                                      thickness: 3,
                                    )
                                  ], alignment: MainAxisAlignment.spaceEvenly),
                                )
                              : Container();
                        },
                      )
                    : Center(
                        child: Text('Loading...'),
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
