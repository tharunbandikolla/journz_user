import 'package:Journz/Articles/DataModel/ArticlesModel.dart';
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
import '/Common/Constant/Constants.dart';
import '/HomeScreen/Bloc/ArticleCubit/article_cubit.dart';
import '/SearchArticles/Cubit/cubit/searchcubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchArticleScreen extends StatefulWidget {
  const SearchArticleScreen({Key? key}) : super(key: key);

  @override
  _SearchArticleScreenState createState() => _SearchArticleScreenState();
}

class _SearchArticleScreenState extends State<SearchArticleScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<ArticleCubit>().getDataForArticleSection('All');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final search = BlocProvider.of<SearchcubitCubit>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: getWidth(context),
          height: getHeight(context),
          child: Column(
            children: [
              35.heightBox,
              TextField(
                controller: searchController,
                onChanged: (val) {
                  search.getSearchText(val.trim());
                },
                decoration: InputDecoration(hintText: "Search Article Here"),
              ).box.p16.make(),
              BlocBuilder<ArticleCubit, ArticleState>(
                builder: (context, sState) {
                  return StreamBuilder(
                    stream: sState.articleStream,
                    builder: (context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? Container(
                              width: context.screenWidth,
                              height: context.screenHeight * 0.84,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return BlocBuilder<SearchcubitCubit,
                                        SearchcubitState>(
                                      builder: (context, seState) {
                                        ArticlesModel model =
                                            ArticlesModel.fromJson(
                                                snapshot.data.docs[index]);
                                        return snapshot.data.docs[index]
                                                    ['IsArticlePublished'] ==
                                                "Published"
                                            ? seState.search != null
                                                ? snapshot
                                                            .data
                                                            .docs[index]
                                                                ['ArticleTitle']
                                                            .toString()
                                                            .toLowerCase()
                                                            .trim()
                                                            .contains(seState
                                                                .search!
                                                                .toLowerCase()
                                                                .trim()) ||
                                                        snapshot
                                                            .data
                                                            .docs[index][
                                                                'ArticleDescription']
                                                            .toString()
                                                            .toLowerCase()
                                                            .trim()
                                                            .contains(seState
                                                                .search!
                                                                .toLowerCase()
                                                                .trim())
                                                    ? InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MultiBlocProvider(
                                                                            providers: [
                                                                              BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                              BlocProvider(create: (context) => ArticlelikeCubit()),
                                                                              BlocProvider(create: (context) => BookmarkCubit()),
                                                                              BlocProvider(create: (context) => ArticlesdetailCubit()),
                                                                              BlocProvider(create: (context) => ArticlelikeCubit()),
                                                                              BlocProvider(create: (context) => CheckuserloginedCubit()),
                                                                              BlocProvider(create: (context) => DetailviewdynamiclinkCubit()),
                                                                              BlocProvider(create: (context) => CommentStreamCubit()),
                                                                              BlocProvider(create: (context) => ArticletitleCubit()),
                                                                              BlocProvider(create: (context) => CommentnumbersCubit()),
                                                                              BlocProvider(create: (context) => ArticlereportCubit()),
                                                                              BlocProvider(create: (context) => BookmarkCubit())
                                                                            ],
                                                                            child:
                                                                                ArticlesDetailViewScreen(
                                                                              title: snapshot.data.docs[index]['ArticleTitle'],
                                                                              fromReviewOrReject: false,
                                                                              documentId: snapshot.data.docs[index].id,
                                                                              fromNotification: false,
                                                                              fromEdit: false,
                                                                            ),
                                                                          )));
                                                        },
                                                        child: Column(
                                                          children: [
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  CheckuserloginedCubit(),
                                                              child:
                                                                  ArticleCard(
                                                                fromReviewAndReject:
                                                                    false,
                                                                model: model,
                                                                docid: model
                                                                    .documentId!, //snapshot.data.docs[index].id,
                                                                title: model
                                                                    .articletitle!,
                                                                desc: model
                                                                    .articledesc!,
                                                              )
                                                                      .box
                                                                      .margin(EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              context.screenWidth * 0.025))
                                                                      .make(),
                                                            ),
                                                            /*                          Divider(
                                                                                                        thickness: 3,
                                                                                                      )*/
                                                            13.heightBox
                                                          ],
                                                        )

                                                        /* VStack([
                                                          VStack([
                                                            Text(snapshot.data
                                                                            .docs[
                                                                        index][
                                                                    'ArticleTitle'])
                                                                .text
                                                                .bold
                                                                .ellipsis
                                                                .xl
                                                                .make(),
                                                            15.heightBox,
                                                            Text(snapshot.data
                                                                            .docs[
                                                                        index][
                                                                    'ArticleDescription'])
                                                                .text
                                                                .lg
                                                                .maxLines(2)
                                                                .ellipsis
                                                                .make(),
                                                            5.heightBox,
                                                          ],
                                                                  alignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly)
                                                              .box
                                                              .p12
                                                              .margin(EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      getWidth(
                                                                              context) *
                                                                          0.03,
                                                                  vertical: getWidth(
                                                                          context) *
                                                                      0.015))
                                                              .make(),
                                                          Divider(
                                                            thickness: 3,
                                                          )
                                                        ],
                                                            alignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly), */
                                                        )
                                                    : Container()
                                                : Container()
                                            : Container();
                                      },
                                    );
                                  }),
                            )
                          : Center(
                              child: Text('Loading...'),
                            );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
