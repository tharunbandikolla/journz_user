part of 'show_comment_cubit.dart';

class ShowCommentState {
  List<HiveArticlesComments>? listOfComment;
  ShowCommentState({this.listOfComment});

  ShowCommentState copyWith(List<HiveArticlesComments>? data) {
    return ShowCommentState(listOfComment: data);
  }
}
