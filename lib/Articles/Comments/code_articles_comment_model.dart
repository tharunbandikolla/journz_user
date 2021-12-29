import 'package:cloud_firestore/cloud_firestore.dart';

class CodeArticlesCommentModel {
  String? comment;
  String? commentTime;
  String? commentUid;
  String? commentName;
  FieldValue? timeStamp;

  CodeArticlesCommentModel(
      {this.commentName,
      this.comment,
      this.commentTime,
      this.commentUid,
      this.timeStamp});

  CodeArticlesCommentModel.fromJson(DocumentSnapshot json) {
    comment = json['Comment'];
    commentTime = json['CommentedTime'];
    commentUid = json['CommenterUid'];
    commentName = json['CommenterName'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['Comment'] = comment;
    data['CommentedTime'] = commentTime;
    data['CommenterUid'] = commentUid;
    data['CommenterName'] = commentName;
    data['TimeStamp'] = timeStamp;
    return data;
  }
}
