part of 'get_articles_from_cloud_cubit.dart';

class GetArticlesFromCloudState {
  List<CodeArticleData>? data;
  GetArticlesFromCloudState({this.data});

  GetArticlesFromCloudState copyWith(List<CodeArticleData> d) {
    return GetArticlesFromCloudState(data: d);
  }
}
