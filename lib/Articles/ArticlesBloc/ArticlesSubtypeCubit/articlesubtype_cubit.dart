import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'articlesubtype_state.dart';

class ArticlesubtypeCubit extends Cubit<ArticlesubtypeState> {
  List<String>? articleSubtype = [];
  String? authorName, authorUid, authorProfilePic;
  int? noOfArticlesPosted;
  ArticlesubtypeCubit()
      : super(ArticlesubtypeState(
            subtype: [],
            authorName: '',
            authorUid: '',
            noOfArticlesUnderCategory: 0));

  getArticleSubTypeFromDB() async {
    FirebaseFirestore.instance
        .collection('ArticleSubtype')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        articleSubtype!.add(element['SubType'].toString());
        emit(state.copyWith(list: articleSubtype));
      });
    });
  }

  getAuthorNameFromDB() {
    FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      print('nnn ${event.data()!['UserName']}');
      authorName = event.data()!['Name'];
      authorUid = event.data()!['UserUid'];
      noOfArticlesPosted = event.data()!['NoOfArticlesPosted'];

      emit(state.copyWith(
          name: authorName,
          uid: authorUid,
          noOfArticlesPosted: noOfArticlesPosted));
    });
  }

  getNoOfArticleUnderCategory(String category) async {
    FirebaseFirestore.instance
        .collection('ArticleSubtype')
        .where('SubType', isEqualTo: category.trim())
        .get()
        .then((value) async {
      if (value.size != 0) {
        print('nnn cubit no ${await value.docs.first.data()['NoOfArticles']}');
        emit(
            state.copyWith(nos: await value.docs.first.data()['NoOfArticles']));
      }
    });
  }
}
