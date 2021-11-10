import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'homescreenlike_state.dart';

class HomescreenlikeCubit extends Cubit<HomescreenlikeState> {
  HomescreenlikeCubit()
      : super(HomescreenlikeState(noOfLike: '0', isLiked: false));

  getInitialstate(String docId) {
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
    });
    Future.delayed(Duration(milliseconds: 1200), () {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        if (like!.contains(FirebaseAuth.instance.currentUser!.uid)) {
          emit(state.copyWith(likeBool: true, likeNos: likenos.toString()));
        } else {
          emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
        }
      } else {
        emit(state.copyWith(likeBool: false, likeNos: likenos.toString()));
      }
    });
  }
}
