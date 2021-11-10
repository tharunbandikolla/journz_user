import 'package:bloc/bloc.dart';
import 'package:journz_web/articleDetailsView/DataService/ArticlesDetailViewDB.dart';


part 'comment_state.dart';

class CommentStreamCubit extends Cubit<CommentCubitState> {
  CommentStreamCubit()
      : super(CommentCubitState(commentStream: Stream.empty()));

  getStream(String documentId) async {
    Stream commentStreamFromDb =
        await ArticleDetailViewDB().commentStreamFunc(documentId);

    emit(state.copyWith(comment: commentStreamFromDb));
  }
}
