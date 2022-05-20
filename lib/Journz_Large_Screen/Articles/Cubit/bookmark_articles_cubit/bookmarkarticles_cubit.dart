import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'bookmarkarticles_state.dart';

class BookmarkarticlesCubit extends Cubit<BookmarkarticlesState> {
  BookmarkarticlesCubit() : super(BookmarkarticlesState(isBookmarked: false));

  listenForBookmark(String uid, String docid) {
    FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(uid)
        .collection('BookmarkedArticles')
        .where('DocumentId', isEqualTo: docid)
        .get()
        .then((value) {
      if (value.size != 0) {
        emit(state.copyWith(true));
      } else {
        emit(state.copyWith(false));
      }
    });
  }
}
