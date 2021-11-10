import 'package:cloud_firestore/cloud_firestore.dart';

class ArticlesSubtypeModel {
  String? subTypeName, photoUrl;
  ArticlesSubtypeModel({this.photoUrl, this.subTypeName});

  ArticlesSubtypeModel.fromJson(DocumentSnapshot json) {
    subTypeName = json['SubType'];
    photoUrl = json['PhotoPath'];
  }
}
