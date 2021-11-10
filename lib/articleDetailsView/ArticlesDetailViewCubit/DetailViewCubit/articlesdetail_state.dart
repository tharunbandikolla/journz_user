part of 'articlesdetail_cubit.dart';

class ArticlesdetailState {
  Stream? articlesDetailStream;
  String title;
  ArticlesdetailState(
      {required this.articlesDetailStream, required this.title});

  ArticlesdetailState copyWith({Stream? detailStream, String? t}) {
    return ArticlesdetailState(
        articlesDetailStream: detailStream ?? this.articlesDetailStream,
        title: t ?? this.title);
  }
}
