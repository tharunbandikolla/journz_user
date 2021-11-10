import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

part 'staticarticlelike_state.dart';

class StaticarticlelikeCubit extends Cubit<StaticarticlelikeState> {
  StaticarticlelikeCubit()
      : super(StaticarticlelikeState(isLiked: false, noOfLike: '0'));

  getInitialstate(int? likenos, List<dynamic>? like) async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      if (like!.contains(FirebaseAuth.instance.currentUser?.uid)) {
        emit(state.copyWith(likeBool: true, likeNos: likenos.toString()));
      } else {
        emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
      }
    } else {
      emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
    }
  }

  likedArticle(int? likenos, List<dynamic>? like, String docId) async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      if (!like!.contains(FirebaseAuth.instance.currentUser!.uid)) {
        likenos = likenos! + 1;
        like.add(FirebaseAuth.instance.currentUser!.uid);
        FirebaseFirestore.instance
            .collection('ArticlesCollection')
            .doc(docId)
            .update({'NoOfLikes': '$likenos', 'ArticleLike': like});

        emit(state.copyWith(
            likeBool: true, likeNos: likenos.toString(), like: like));
      }
    } else {
      emit(state.copyWith(
          likeBool: false, likeNos: likenos.toString(), like: like));
    }
  }

  disLikeArticle(int? likenos, List<dynamic>? like, String docId) async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      if (like!.contains(FirebaseAuth.instance.currentUser!.uid)) {
        likenos = likenos! - 1;
        like.remove(FirebaseAuth.instance.currentUser!.uid);
        FirebaseFirestore.instance
            .collection('ArticlesCollection')
            .doc(docId)
            .update({'NoOfLikes': '$likenos', 'ArticleLike': like});
        emit(state.copyWith(
            likeBool: false, likeNos: likenos.toString(), like: like));
      } else {
        emit(state.copyWith(
            likeBool: false, likeNos: likenos.toString(), like: like));
      }
    } else {
      emit(state.copyWith(
          likeBool: false, likeNos: likenos.toString(), like: like));
    }
  }
}
