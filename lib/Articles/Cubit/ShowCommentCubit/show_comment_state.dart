part of 'show_comment_cubit.dart';

class ShowCommentState {
  final List<HiveArticlesComments>? listOfComment;
  const ShowCommentState({this.listOfComment});

  ShowCommentState copyWith(List<HiveArticlesComments> data) {
    return ShowCommentState(listOfComment: data);
  }
}
