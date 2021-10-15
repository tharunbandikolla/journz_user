import 'package:cloud_firestore/cloud_firestore.dart';

class BookMarkDataModel {
  String? docid, authorName, title;

  BookMarkDataModel(
      {required this.docid, required this.authorName, required this.title});

  BookMarkDataModel.fromJson(DocumentSnapshot json) {
    docid = json['DocumentId'];
    authorName = json['AuthorName'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();

    json['DocumentId'] = this.docid;
    json['AuthorName'] = this.authorName;
    json['Title'] = this.title;

    return json;
  }
}
