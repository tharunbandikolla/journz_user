import 'package:cloud_firestore/cloud_firestore.dart';

class CodeArticleData {
  late String? articleDescription;

  late List<dynamic>? articleLike;

  late String? articlePhotoUrl;

  late List<dynamic>? articleReportedBy;

  late String? articleSubtype;

  late String? articleTitle;

  late String? authorName;

  late String? authorUid;

  late List<dynamic>? bookmarkedBy;

  late List<dynamic>? country;

  late String? documentId;

  late List<dynamic>? galleryImages;

  late String? isArticlePublished;

  late String? isArticleReported;

  late int? noOflikes;

  late int? noOfViews;

  late int? noOfComments;

  late String? socialMediaLink;

  CodeArticleData(
      {this.articleDescription,
      this.articleLike,
      this.articlePhotoUrl,
      this.articleReportedBy,
      this.articleSubtype,
      this.articleTitle,
      this.authorName,
      this.authorUid,
      this.bookmarkedBy,
      this.country,
      this.documentId,
      this.galleryImages,
      this.isArticlePublished,
      this.isArticleReported,
      this.noOfComments,
      this.noOfViews,
      this.noOflikes,
      this.socialMediaLink});

  CodeArticleData.fromJson(DocumentSnapshot json) {
    articleTitle = json['ArticleTitle'];
    articleDescription = json['ArticleDescription'];
    articleLike = json['ArticleLike'];
    articlePhotoUrl = json['ArticlePhotoUrl'];
    articleSubtype = json['ArticleSubtype'];
    authorName = json['AuthorName'];
    authorUid = json['AuthorUid'];
    bookmarkedBy = json['BookmarkedBy'];
    country = json['Country'];
    documentId = json['DocumentId'];
    galleryImages = json['GalleryImages'];
    isArticlePublished = json['IsArticlePublished'];
    isArticleReported = json['IsArticleReported'];
    noOfComments = json['NoOfComments'];
    noOflikes = json['NoOfLikes'];
    noOfViews = json['NoOfViews'];
    articleReportedBy = json['ArticleReportedBy'];
    socialMediaLink = json['SocialMedialink'];
  }
}
