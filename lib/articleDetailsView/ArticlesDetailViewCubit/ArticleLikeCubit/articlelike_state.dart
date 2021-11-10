part of 'articlelike_cubit.dart';

class ArticlelikeState {
  bool? isLiked;
  ArticlelikeState({this.isLiked});

  ArticlelikeState copyWith({bool? likeBool}) {
    return ArticlelikeState(isLiked: likeBool!);
  }
}
