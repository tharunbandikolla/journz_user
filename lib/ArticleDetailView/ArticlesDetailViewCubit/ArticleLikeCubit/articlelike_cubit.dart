import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'articlelike_state.dart';

class ArticlelikeCubit extends Cubit<ArticlelikeState> {
  ArticlelikeCubit() : super(ArticlelikeState(isLiked: false, noOfLike: '0'));

  getInitialstate(String docId) async {
    late int? likenos;
    late List<dynamic>? like;
    late String? noOfLike;

    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docId)
        .get()
        .then((event) async {
      like = await event.data()?['ArticleLike'];
      noOfLike = await event.data()?['NoOfLikes'];
      likenos = int.parse(noOfLike!);
    }).then((value) {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        if (like!.contains(FirebaseAuth.instance.currentUser?.uid)) {
          emit(state.copyWith(likeBool: true, likeNos: likenos.toString()));
        } else {
          emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
        }
      } else {
        emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
      }
    });
  }

  likedArticle(String docId) async {
    print('nnn l like');
    int? likenos;
    List<dynamic>? like;
    String? noOfLike;
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docId)
        .get()
        .then((event) async {
      like = await event.get('ArticleLike');
      noOfLike = await event.get('NoOfLikes');
      likenos = int.parse(noOfLike!);
    }).then((value) {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        if (!like!.contains(FirebaseAuth.instance.currentUser!.uid)) {
          likenos = likenos! + 1;
          like!.add(FirebaseAuth.instance.currentUser!.uid);
          FirebaseFirestore.instance
              .collection('ArticlesCollection')
              .doc(docId)
              .update({'NoOfLikes': likenos.toString(), 'ArticleLike': like});
          emit(state.copyWith(likeBool: true, likeNos: likenos.toString()));
        }
      } else {
        emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
      }
    });
  }

  disLikeArticle(String docId) async {
    print('nnn l dislike');
    int? likenos;
    List<dynamic>? like;
    String? noOfLike;
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docId)
        .get()
        .then((event) async {
      like = await event.get('ArticleLike');
      noOfLike = await event.get('NoOfLikes');
      likenos = int.parse(noOfLike!);
    }).then((value) {
      print('nnn l func dislike');
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        if (like!.contains(FirebaseAuth.instance.currentUser!.uid)) {
          likenos = likenos! - 1;
          like!.remove(FirebaseAuth.instance.currentUser!.uid);
          FirebaseFirestore.instance
              .collection('ArticlesCollection')
              .doc(docId)
              .update({'NoOfLikes': likenos.toString(), 'ArticleLike': like});
          emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
        } else {
          emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
        }
      } else {
        emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
      }
    });
  }
}
