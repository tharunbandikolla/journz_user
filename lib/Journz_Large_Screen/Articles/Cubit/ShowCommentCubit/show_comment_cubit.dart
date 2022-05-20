import 'package:bloc/bloc.dart';

import '/Journz_Large_Screen/Articles/Comments/hive_articles_comments.dart';

part 'show_comment_state.dart';

class ShowCommentCubit extends Cubit<ShowCommentState> {
  ShowCommentCubit() : super(ShowCommentState(listOfComment: null));

  listenForComment(List<HiveArticlesComments>? val) {
    emit(state.copyWith(val));
  }
}
