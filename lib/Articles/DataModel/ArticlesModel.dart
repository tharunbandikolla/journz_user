import 'package:cloud_firestore/cloud_firestore.dart';

class ArticlesModel {
  String? authorName,
      authorUid,
      documentId,
      articletitle,
      sentNotificatonForPublished,
      noOfLike,
      articledesc,
      articleSubType,
      hasImage,
      noOfComment,
      isArticlePublished,
      photoUrl,
      socialMediaLink,
      isArticleReported;
  FieldValue? createdTimeFieldValue, updatedTimeFieldValue;
  Timestamp? createdTime, updatedTime;
  List<dynamic>? searchKey;
  List<dynamic>? peopleLike;
  List<dynamic>? bookMarkedPeoples = [];
  List<dynamic>? reportedPeoples = [];
  List<dynamic>? galleryImages = [];
  bool? isBookmarked = false;
  int? noOfViews;
  Uri? socialMediaUriLink;

  ArticlesModel(
      {this.authorName,
      this.sentNotificatonForPublished,
      this.authorUid,
      this.documentId,
      this.articletitle,
      this.articledesc,
      this.articleSubType,
      this.bookMarkedPeoples,
      this.createdTime,
      this.updatedTime,
      this.isArticlePublished,
      this.isArticleReported,
      this.hasImage,
      this.noOfLike,
      this.peopleLike,
      this.socialMediaLink,
      this.socialMediaUriLink,
      this.photoUrl,
      //this.isBookmarked,
      this.createdTimeFieldValue,
      this.updatedTimeFieldValue,
      this.noOfComment,
      this.reportedPeoples,
      this.noOfViews,
      this.galleryImages
      /*this.searchKey*/
      });

  ArticlesModel.fromJson(DocumentSnapshot json) {
    authorName = json['AuthorName'];
    authorUid = json['AuthorUID'];
    articletitle = json['ArticleTitle'];
    articledesc = json['ArticleDescription'];
    articleSubType = json['ArticleSubType'];
    createdTime = json['CreatedTime'];
    updatedTime = json['UpdatedTime'];
    hasImage = json['HasImage'];
    isArticlePublished = json['IsArticlePublished'];
    isArticleReported = json['IsArticleReported'];
    photoUrl = json['ArticlePhotoUrl'];
    noOfLike = json['NoOfLikes'];
    bookMarkedPeoples = json['BookmarkedBy'];
    peopleLike = json['ArticleLike'];
    noOfComment = json['NoOfComment'];
    reportedPeoples = json['ArticleReportedBy'];
    documentId = json['DocumentId'];
    noOfViews = json['NoOfViews'];
    galleryImages = json['GalleryImages'];
    socialMediaLink = json['SocialMediaLink'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['AuthorName'] = this.authorName;
    json['AuthorUID'] = this.authorUid;
    json['ArticleTitle'] = this.articletitle;
    //json['ArticleSearchKey'] = this.searchKey;
    json['ArticleDescription'] = this.articledesc;
    json['ArticleSubType'] = this.articleSubType;
    json['CreatedTime'] = this.createdTimeFieldValue;
    json['UpdatedTime'] = this.updatedTimeFieldValue;
    json['IsArticlePublished'] = this.isArticlePublished;
    json['IsArticleReported'] = this.isArticleReported;
    json['HasImage'] = this.hasImage;
    json['ArticlePhotoUrl'] = this.photoUrl;
    json['NoOfLikes'] = this.noOfLike;
    json['ArticleLike'] = this.peopleLike;
    json['NoOfComment'] = this.noOfComment;
    json['BookmarkedBy'] = this.bookMarkedPeoples;
    json['ArticleReportedBy'] = this.reportedPeoples;
    json['DocumentId'] = this.documentId;
    json['NoOfViews'] = this.noOfViews;
    json['GalleryImages'] = this.galleryImages;
    json['SentNotificatonForPublished'] = this.sentNotificatonForPublished;
    json['SocialMediaLink'] = this.socialMediaLink;
    return json;
  }
}
