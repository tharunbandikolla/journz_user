part of 'articlelike_cubit.dart';

class ArticlelikeState {
  String? noOfLike;
  bool? isLiked;
  ArticlelikeState({this.noOfLike, this.isLiked});

  ArticlelikeState copyWith({String? likeNos, bool? likeBool}) {
    return ArticlelikeState(noOfLike: likeNos, isLiked: likeBool!);
  }
}
