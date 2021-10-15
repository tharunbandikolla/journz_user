import '/ArticleDetailView/ArticlesDetailViewCubit/CommentNumbers/commentnumbers_cubit.dart';
import '/Common/Helper/CheckUserLoginedCubit/checkuserlogined_cubit.dart';
import 'package:velocity_x/velocity_x.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleLikeCubit/articlelike_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleReportCubit/articlereport_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/ArticleTitleCubit/articletitle_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookMarkCubit/bookmarkcubit_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/BookmarkScreenCubit/bookmarkscreen_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/CommentCubit/comment_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewCubit/articlesdetail_cubit.dart';
import '/ArticleDetailView/ArticlesDetailViewCubit/DetailViewDynamicLink/detailviewdynamiclink_cubit.dart';
import '/ArticleDetailView/DataModel/BookmarkDataModel.dart';
import '/ArticleDetailView/Screen/ArticleDetaillViewScreen.dart';
import '/Common/Constant/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkedArticlesScreen extends StatefulWidget {
  const BookmarkedArticlesScreen({Key? key}) : super(key: key);

  @override
  _BookmarkedArticlesScreenState createState() =>
      _BookmarkedArticlesScreenState();
}

class _BookmarkedArticlesScreenState extends State<BookmarkedArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    final bookmarkScreenCubit = BlocProvider.of<BookmarkscreenCubit>(context);
    bookmarkScreenCubit.getStream();
    return Scaffold(
      appBar: AppBar(title: Text('Favourite Article')),
      body: BlocBuilder<BookmarkscreenCubit, BookmarkscreenState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(getWidth(context) * 0.01),
            width: getWidth(context),
            height: getHeight(context),
            child: StreamBuilder(
              stream: state.bookmarkStream,
              builder: (context, AsyncSnapshot snapshot) {
                print('nnn index ${snapshot.data?.docs.length}');

                return snapshot.hasData
                    ? snapshot.data!.docs.length == 0
                        ? Center(child: Text('Favourite Article Is Empty'))
                        : ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              BookMarkDataModel model =
                                  BookMarkDataModel.fromJson(
                                      snapshot.data.docs[index]);
                              print('nnn index $index');
                              return InkWell(
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
                                                child: ArticlesDetailViewScreen(
                                                  title: model.title!,
                                                  fromReviewOrReject: false,
                                                  documentId: model.docid!,
                                                  fromNotification: false,
                                                  fromEdit: false,
                                                ),
                                              )));
                                },
                                child: VStack([
                                  VStack([
                                    Text(model.authorName!)
                                        .text
                                        .bold
                                        .ellipsis
                                        .xl
                                        .make(),
                                    15.heightBox,
                                    Text(model.title!)
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
                                          horizontal: getWidth(context) * 0.03,
                                          vertical: getWidth(context) * 0.015))
                                      .make(),
                                  Divider(
                                    thickness: 3,
                                  )
                                ], alignment: MainAxisAlignment.spaceEvenly),

                                /* Card(
                                  elevation: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        getWidth(context) * 0.025),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(model.authorName!),
                                        SizedBox(
                                          height: getWidth(context) * 0.05,
                                        ),
                                        Text(model.title!),
                                      ],
                                    ),
                                  ),
                                ),*/
                              );
                            },
                          )
                    : Center(child: Text('Article Loading...'));
              },
            ),
          );
        },
      ),
    );
  }
}
