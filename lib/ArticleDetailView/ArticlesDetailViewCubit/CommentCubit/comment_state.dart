part of 'comment_cubit.dart';

class CommentCubitState {
  Stream? commentStream;

  CommentCubitState({this.commentStream});

  CommentCubitState copyWith({Stream? comment}) {
    return CommentCubitState(commentStream: comment);
  }
}
