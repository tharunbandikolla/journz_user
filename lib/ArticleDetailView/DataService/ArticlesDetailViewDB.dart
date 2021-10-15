import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleDetailViewDB {
  getArticlesDetailViewStream(String docid) {
    return FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docid)
        .snapshots();
  }

  getArticlesTitle(String docid) async {
    return await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docid)
        .get();
  }

  bookMarkArticlesInDB(
      String uid, String bookmarkId, String title, String authorName) async {
    return await FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(uid)
        .collection('BookmarkedArticles')
        .doc(bookmarkId)
        .set({
      'DocumentId': bookmarkId,
      'Title': title,
      'AuthorName': authorName,
    });
  }

  bookMarkInArticles(String docid, List<dynamic> uid) async {
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docid)
        .update({'BookmarkedBy': uid});
  }

  checkArticleBookmarkedInDB(String uid, String bookmarkId) {
    return FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(uid)
        .collection('BookmarkedArticles')
        .where('DocumentId', isEqualTo: bookmarkId)
        .snapshots();
  }

  removeBookmarkedArticleInDB(String uid, String bookmarkId) {
    return FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(uid)
        .collection('BookmarkedArticles')
        .doc(bookmarkId)
        .delete();
  }

  bookmarkStream(String uid) {
    return FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(uid)
        .collection('BookmarkedArticles')
        .snapshots();
  }

  postComment(String primaryDoc, Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(primaryDoc)
        .collection('Comments')
        .doc()
        .set(data);
  }

  commentPersonName(String uid) async {
    return await FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(uid)
        .get();
  }

  commentStreamFunc(String documentId) async {
    return FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(documentId)
        .collection('Comments')
        .orderBy('CreatedTime', descending: true)
        .snapshots();
  }

  commentCountFunc(String documentId) async {
    return await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(documentId)
        .get();
  }

  checkIsArticleReported(String documentId) async {
    return await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(documentId)
        .get();
  }

  updateReportDetailsInArticle(String documentid, String reason, List data) {
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(documentid)
        .update({'ArticleReportedBy': data});
  }

  reportArticleInDB(
      String docName, String title, String authorName, String subtype) {
    FirebaseFirestore.instance
        .collection('ReportedArticlesByUsers')
        .doc(docName)
        .set({
      'ParentId': docName,
      'Title': title,
      'AuthorName': authorName,
      'SubType': subtype
    });
  }

  putZeroInComment(String documentId) {
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(documentId)
        .collection('Comments')
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection('ArticlesCollection')
          .doc(documentId)
          .update({'NoOfComment': value.size.toString()});
    });
  }

  getviewsoFAnArticle(String docid) async {
    return await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docid)
        .get();
  }

  addviewsForAnArticle(String docid, int nos) {
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docid)
        .update({'NoOfViews': nos});
  }
}
