import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journz_web/articleDetailsView/DataService/ArticlesDetailViewDB.dart';


part 'bookmarkcubit_state.dart';

class BookmarkCubit extends Cubit<BookmarkcubitState> {
  BookmarkCubit() : super(BookmarkcubitState(isBookmarked: false));

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

  bookmarkArticleInArticleCollection(String docId) {
    if (FirebaseAuth.instance.currentUser != null) {
      List<dynamic> bookmarkedPeoples = [];
      FirebaseFirestore.instance
          .collection('ArticlesCollection')
          .doc(docId)
          .get()
          .then((value) async {
        bookmarkedPeoples = await value.get('BookmarkedBy');
        if (bookmarkedPeoples
            .contains(FirebaseAuth.instance.currentUser!.uid)) {
          print('nnn Already Bookmarked');
        } else {
          print('nnn Already not Bookmarked');
          bookmarkedPeoples.add(FirebaseAuth.instance.currentUser!.uid);
          ArticleDetailViewDB().bookMarkInArticles(docId, bookmarkedPeoples);
        }
      });
    }
  }

  removeBookmarkArticleInArticleCollection(String docId) {
    if (FirebaseAuth.instance.currentUser != null) {
      List<dynamic> bookmarkedPeoples = [];
      FirebaseFirestore.instance
          .collection('ArticlesCollection')
          .doc(docId)
          .get()
          .then((value) async {
        bookmarkedPeoples = await value.get('BookmarkedBy');
        if (bookmarkedPeoples
            .contains(FirebaseAuth.instance.currentUser!.uid)) {
          print('nnn Already Bookmarked');
          bookmarkedPeoples.remove(FirebaseAuth.instance.currentUser!.uid);
          ArticleDetailViewDB().bookMarkInArticles(docId, bookmarkedPeoples);
        } else {
          print('nnn Already not Bookmarked');
        }
      });
    }
  }

  bookMarkArticleInUserCollection(
      String uid, String bookmarkId, String title, String authorName) {
    ArticleDetailViewDB()
        .bookMarkArticlesInDB(uid, bookmarkId, title, authorName);
    emit(state.copyWith(bookmark: true));
  }

  removeBookmarkedArticleInUserCollection(String uid, String bookmarkId) {
    ArticleDetailViewDB().removeBookmarkedArticleInDB(uid, bookmarkId);
    emit(state.copyWith(bookmark: false));
  }
}
