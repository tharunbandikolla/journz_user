import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ArticleDatabase {
  getArticleStream() {
    return FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .orderBy('UpdatedTime', descending: true)
        .snapshots();
  }

  getArticleSubtype() {
    return FirebaseFirestore.instance.collection('ArticleSubtype').snapshots();
  }

  String getArticleSubtypeFirst() {
    String val = '';
    FirebaseFirestore.instance
        .collection('ArticleSubtype')
        .snapshots()
        .listen((event) {
      print('nnn firstdoc ${event.docs.first['SubType']}');
      val = event.docs.first['SubType'];
    });
    return val;
  }

  getAppUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }
}
