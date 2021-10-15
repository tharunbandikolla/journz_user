import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/ArticleDetailView/DataService/ArticlesDetailViewDB.dart';

part 'homescreenbookmark_state.dart';

class HomescreenbookmarkCubit extends Cubit<HomescreenbookmarkState> {
  HomescreenbookmarkCubit()
      : super(HomescreenbookmarkState(isBookmarked: false));

  checkBookmarked(String uid, String bookmarkId) {
    ArticleDetailViewDB()
        .checkArticleBookmarkedInDB(uid, bookmarkId)
        .listen((event) {
      if (event.size != 0) {
        emit(state.copyWith(bookmark: true));
      } else {
        emit(state.copyWith(bookmark: false));
      }
    });
  }
}
