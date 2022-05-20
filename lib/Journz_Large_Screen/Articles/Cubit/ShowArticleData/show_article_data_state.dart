part of 'show_article_data_cubit.dart';

class ShowArticleDataState {
  final HiveArticleData? hiveArticleData;
  const ShowArticleDataState({this.hiveArticleData});

  ShowArticleDataState copyWith(HiveArticleData data) {
    return ShowArticleDataState(hiveArticleData: data);
  }
}
