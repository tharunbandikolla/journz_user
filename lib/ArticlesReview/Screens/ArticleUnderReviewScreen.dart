import 'package:Journz/Common/Widgets/AricleCard.dart';

import '/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/ArticleDetailView/Screen/ArticleDetaillViewScreen.dart';
import '/Articles/DataModel/ArticlesModel.dart';
import '/ArticlesReview/Cubit/cubit/Reviewarticlestream_cubit.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleUnderReviewScreen extends StatefulWidget {
  const ArticleUnderReviewScreen({Key? key}) : super(key: key);

  @override
  _ArticleUnderReviewScreenState createState() =>
      _ArticleUnderReviewScreenState();
}

class _ArticleUnderReviewScreenState extends State<ArticleUnderReviewScreen> {
  @override
  void initState() {
    context.read<ReviewarticlestreamCubit>().getPostedArticleStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Articles UnderReview'.text.bold.make(),
      ),
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        padding: EdgeInsets.only(top: context.screenWidth * 0.05),
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
                          ArticlesModel model =
                              ArticlesModel.fromJson(snapshot.data.docs[index]);
                          return snapshot.data.docs[index]
                                      ['IsArticlePublished'] ==
                                  "UnderReview"
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
                                                            DetailviewdynamiclinkCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            ArticlelikeCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            BookmarkCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            ArticlesdetailCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            ArticlelikeCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            CheckuserloginedCubit()),
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
                                                            CommentnumbersCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            ArticlereportCubit()),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            BookmarkCubit())
                                                  ],
                                                  child:
                                                      ArticlesDetailViewScreen(
                                                    title: snapshot
                                                            .data.docs[index]
                                                        ['ArticleTitle'],
                                                    fromReviewOrReject: true,
                                                    data: model,
                                                    documentId: snapshot
                                                        .data.docs[index].id,
                                                    fromNotification: false,
                                                    fromEdit: true,
                                                  ),
                                                )));
                                  },
                                  child: Column(
                                    children: [
                                      BlocProvider(
                                        create: (context) =>
                                            CheckuserloginedCubit(),
                                        child: ArticleCard(
                                          reviewRejectionMessage: snapshot.data
                                              .docs[index]['ReviewMessage'],
                                          fromReviewAndReject: true,
                                          model: model,
                                          docid: model
                                              .documentId!, //snapshot.data.docs[index].id,
                                          title: model.articletitle!,
                                          desc: model.articledesc!,
                                        )
                                            .box
                                            .margin(EdgeInsets.symmetric(
                                                horizontal:
                                                    context.screenWidth *
                                                        0.025))
                                            .make(),
                                      ),
                                      13.heightBox
                                    ],
                                  )

                                  /* VStack([
                                    VStack([
                                      Text(snapshot.data.docs[index]
                                              ['ArticleTitle'])
                                          .text
                                          .bold
                                          .ellipsis
                                          .xl
                                          .make(),
                                      10.heightBox,
                                      Text(snapshot.data.docs[index]
                                              ['ArticleDescription'])
                                          .text
                                          .lg
                                          .maxLines(2)
                                          .ellipsis
                                          .make(),
                                      10.heightBox,
                                      HStack([
                                        "Rejection Message :"
                                            .text
                                            .lg
                                            .bold
                                            .make()
                                            .box
                                            .width(context.screenWidth * 0.4)
                                            .height(context.screenHeight * 0.15)
                                            .make(),
                                        5.widthBox,
                                        Text(snapshot.data.docs[index]
                                                ['ReviewMessage'])
                                            .text
                                            .xl
                                            .maxLines(2)
                                            .ellipsis
                                            .make()
                                            .box
                                            .width(context.screenWidth * 0.45)
                                            .height(context.screenHeight * 0.15)
                                            .make(),
                                      ])
                                          .box
                                          .width(context.screenWidth * 1.1)
                                          .height(context.screenWidth * 0.2)
                                          .make()
                                    ], alignment: MainAxisAlignment.spaceEvenly)
                                        .box
                                        .p12
                                        .margin(EdgeInsets.symmetric(
                                            horizontal:
                                                getWidth(context) * 0.03,
                                            vertical: getWidth(context) * 0.05))
                                        .make(),
                                    Divider(
                                      thickness: 3,
                                    )
                                  ], alignment: MainAxisAlignment.spaceEvenly), */
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
