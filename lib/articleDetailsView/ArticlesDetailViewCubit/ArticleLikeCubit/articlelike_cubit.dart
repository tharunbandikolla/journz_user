import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'articlelike_state.dart';

class ArticlelikeCubit extends Cubit<ArticlelikeState> {
  ArticlelikeCubit() : super(ArticlelikeState(isLiked: false));

  getInitialstate(String docId) async {
    List like = [];
/* 
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docId)
        .get()
        .then((event) async {
      like = await event.data()?['ArticleLike'];
    }).then((value) { */
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      FirebaseFirestore.instance
          .collection('ArticlesCollection')
          .doc(docId)
          .get()
          .then((value) {
        like = value.data()!['ArticleLike'];

        if (like.contains(FirebaseAuth.instance.currentUser!.uid)) {
          emit(state.copyWith(likeBool: true));
        } else {
          emit(state.copyWith(likeBool: false));
        }
      });
    }
    //});
  }

  likedArticle(String docId) async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      FirebaseFirestore.instance
          .collection('ArticlesCollection')
          .doc(docId)
          .update({
        'NoOfLike': FieldValue.increment(1),
        'ArticleLike':
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      }).then((value) {
        emit(state.copyWith(likeBool: true));
      });
    } else {
      emit(state.copyWith(likeBool: false));
    }
  }

  disLikeArticle(String docId) async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      FirebaseFirestore.instance
          .collection('ArticlesCollection')
          .doc(docId)
          .update({
        'NoOfLike': FieldValue.increment(-1),
        'ArticleLike':
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
      }).then((value) {
        emit(state.copyWith(likeBool: false));
      });
    } else {
      emit(state.copyWith(likeBool: false));
    }
  }
}
