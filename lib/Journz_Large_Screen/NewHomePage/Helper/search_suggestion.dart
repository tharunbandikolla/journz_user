/* import 'package:cloud_firestore/cloud_firestore.dart';

class SearchSuggestion {
  static Future<List<SearchSuggestionData>> suggestionData() async {
    return FirebaseFirestore.instance
        .collection('NewArticleCollection')
        
        .get();
    ;
  }
  /* 
  getDataForSuggestion(String q) async {
    print(q);
    List<SearchSuggestionData> data = [];

    if (q != "") {
      FirebaseFirestore.instance
          .collection('NewArticleCollection')
          //.where('ArticleTitle', isLessThanOrEqualTo: q)
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          if (element['ArticleTitle']
              .toString()
              .toLowerCase()
              .contains(q.toLowerCase())) {
            data.add(SearchSuggestionData(
                articleSubtype: element['ArticleSubtype'],
                articletitle: element['ArticleTitle'],
                docId: element['DocumentId']));
            tryFunc(data);
          }
        });
      });
    }
    return await data;
  }

  tryFunc(List<SearchSuggestionData> val) {
    return val;
  } */
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchSuggestionData {
  late String articletitle;
  late String articleSubtype;
  late String docId;
  SearchSuggestionData(
      {required this.articleSubtype,
      required this.articletitle,
      required this.docId});

  SearchSuggestionData.fromJson(DocumentSnapshot json) {
    articleSubtype = json['ArticleSubtype'];
    articletitle = json['ArticleTitle'];
    docId = json['DocumentId'];
  }
}
