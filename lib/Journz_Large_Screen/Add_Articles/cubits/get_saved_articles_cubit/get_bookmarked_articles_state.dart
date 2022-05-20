part of 'get_bookmarked_articles_cubit.dart';

class GetBookmarkedArticlesState {
  List<String>? savedArticlesId;

  GetBookmarkedArticlesState({required this.savedArticlesId});

  GetBookmarkedArticlesState copyWith(List<String>? data) {
    return GetBookmarkedArticlesState(savedArticlesId: data);
  }
}
