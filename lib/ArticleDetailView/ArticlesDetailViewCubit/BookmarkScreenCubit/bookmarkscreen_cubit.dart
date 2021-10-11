import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/ArticleDetailView/DataService/ArticlesDetailViewDB.dart';

part 'bookmarkscreen_state.dart';

class BookmarkscreenCubit extends Cubit<BookmarkscreenState> {
  BookmarkscreenCubit()
      : super(BookmarkscreenState(
            bookmarkStream: ArticleDetailViewDB()
                .bookmarkStream(FirebaseAuth.instance.currentUser!.uid)));

  getStream() {
    Stream? stream;
    stream = ArticleDetailViewDB()
        .bookmarkStream(FirebaseAuth.instance.currentUser!.uid);
    Future.delayed(Duration(milliseconds: 1000), () {
      if (stream != null) {
        emit(state.copyWith(stream: stream));
      }
    });
  }
}
