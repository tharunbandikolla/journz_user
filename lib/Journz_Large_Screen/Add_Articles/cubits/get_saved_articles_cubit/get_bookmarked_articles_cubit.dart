import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'get_bookmarked_articles_state.dart';

class GetBookmarkedArticlesCubit extends Cubit<GetBookmarkedArticlesState> {
  GetBookmarkedArticlesCubit()
      : super(GetBookmarkedArticlesState(savedArticlesId: []));

  getBookmarkedArticles(String userId) {
    List<String> docId = [];
    FirebaseFirestore.instance
        .collection("UserProfile")
        .doc(userId)
        .collection("BookmarkedArticles")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        docId.add(element.data()["DocumentId"].toString());
        emit(state.copyWith(docId));
      });
    });
  }
}
