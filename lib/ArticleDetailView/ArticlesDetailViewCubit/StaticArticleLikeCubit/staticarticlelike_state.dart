part of 'staticarticlelike_cubit.dart';

class StaticarticlelikeState {
  String? noOfLike;
  bool? isLiked;
  List<dynamic>? peoplesLikeList;
  StaticarticlelikeState({this.noOfLike, this.isLiked, this.peoplesLikeList});

  StaticarticlelikeState copyWith(
      {String? likeNos, bool? likeBool, List<dynamic>? like}) {
    return StaticarticlelikeState(
        noOfLike: likeNos,
        isLiked: likeBool!,
        peoplesLikeList: like ?? this.peoplesLikeList);
  }
}
