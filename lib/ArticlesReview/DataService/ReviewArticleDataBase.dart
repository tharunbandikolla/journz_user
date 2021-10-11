import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewArticleDataBase {
  getPostedArticlesStream() async {
    return FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .where('AuthorUID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
}
