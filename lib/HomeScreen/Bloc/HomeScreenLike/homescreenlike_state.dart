part of 'homescreenlike_cubit.dart';

class HomescreenlikeState {
  String? noOfLike;
  bool? isLiked;
  HomescreenlikeState({this.noOfLike, this.isLiked});

  HomescreenlikeState copyWith({String? likeNos, bool? likeBool}) {
    return HomescreenlikeState(noOfLike: likeNos!, isLiked: likeBool!);
  }
}
