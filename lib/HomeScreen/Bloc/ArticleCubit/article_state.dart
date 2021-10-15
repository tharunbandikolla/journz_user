part of 'article_cubit.dart';

class ArticleState {
  Stream articleStream, articleSubtype;
  String subType;
  ArticleState(
      {required this.articleStream,
      required this.articleSubtype,
      required this.subType});

  ArticleState copyWith(
      {Stream? articleStream, Stream? subTypeStream, String? subtypeString}) {
    return ArticleState(
        articleStream: articleStream ?? this.articleStream,
        articleSubtype: subTypeStream ?? this.articleSubtype,
        subType: subtypeString!);
  }
}
