import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? userName, comment, uid;
  FieldValue? createdTime;

  CommentModel(
      {required this.userName,
      required this.comment,
      required this.uid,
      required this.createdTime});

  CommentModel.fromJson(DocumentSnapshot json) {
    userName = json['CommentedBy'];
    comment = json['Comment'];
    uid = json['CommentById'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['CommentedBy'] = this.userName;
    json['Comment'] = this.comment;
    json['CommentById'] = this.uid;
    json['CreatedTime'] = this.createdTime;
    return json;
  }
}
