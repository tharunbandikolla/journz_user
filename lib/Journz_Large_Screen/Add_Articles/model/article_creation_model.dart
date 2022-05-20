import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleCreationModel {
  String? articleDescription,
      articleTitle,
      articlePhotoUrl,
      articleSubtype,
      authorName,
      authorUid,
      documentId,
      isArticlePublished,
      isArticleReported,
      moderator,
      sentNotificationForPublished,
      socialMediaLink,
      shortDesc;

  int? noOfLikes, noOfComments, noOfViews;
  List<dynamic>? articleLike = [];
  List<dynamic>? articleReportedBy = [];
  List<dynamic>? bookmarkedBy = [];
  List<dynamic>? country = [];
  List<dynamic>? galleryImages = [];
  FieldValue? createdTime, postedTime, updatedTime;

  ArticleCreationModel(
      {this.articleDescription,
      this.articleTitle,
      this.articleLike,
      this.articlePhotoUrl,
      this.articleReportedBy,
      this.articleSubtype,
      this.authorName,
      this.authorUid,
      this.bookmarkedBy,
      this.country,
      this.createdTime,
      this.documentId,
      this.galleryImages,
      this.isArticlePublished,
      this.isArticleReported,
      this.moderator,
      this.noOfComments,
      this.noOfLikes,
      this.noOfViews,
      this.postedTime,
      this.sentNotificationForPublished,
      this.socialMediaLink,
      this.shortDesc});

  ArticleCreationModel.fromJson(DocumentSnapshot json) {
    articleDescription = json['ArticleDescription'];
    articleLike = json['ArticleLike'];
    articlePhotoUrl = json['ArticlePhotoUrl'];
    articleReportedBy = json['ArticleReportedBy'];
    articleSubtype = json['ArticleSubtype'];
    authorName = json['AuthorName'];
    authorUid = json['AuthorUid'];
    bookmarkedBy = json['BookmarkedBy'];
    country = json['Country'];
    createdTime = json['CreatedTime'];
    documentId = json['DocumentId'];
    galleryImages = json['GalleryImages'];
    isArticlePublished = json['IsArticlePublished'];
    isArticleReported = json['IsArticleReported'];
    moderator = json['Moderator'];
    noOfComments = json['NoOfComments'];
    noOfLikes = json['NoOfLikes'];
    noOfViews = json['NoOfViews'];
    postedTime = json['PostedTime'];
    sentNotificationForPublished = json['SentNotificationForPublished'];
    socialMediaLink = json['SocialMedialink'];
    articleTitle = json['ArticleTitle'];
    shortDesc = json['ShortDescription'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();

    json['ArticleDescription'] = articleDescription;
    json['ArticleLike'] = articleLike;
    json['ArticlePhotoUrl'] = articlePhotoUrl;
    json['ArticleReportedBy'] = articleReportedBy;
    json['ArticleSubtype'] = articleSubtype;
    json['AuthorName'] = authorName;
    json['AuthorUid'] = authorUid;
    json['BookmarkedBy'] = bookmarkedBy;
    json['Country'] = country;
    json['CreatedTime'] = createdTime;
    json['DocumentId'] = documentId;
    json['GalleryImages'] = galleryImages;
    json['IsArticlePublished'] = isArticlePublished;
    json['IsArticleReported'] = isArticleReported;
    json['Moderator'] = moderator;
    json['NoOfComments'] = noOfComments;
    json['NoOfLikes'] = noOfLikes;
    json['NoOfViews'] = noOfViews;
    json['PostedTime'] = postedTime;
    json['SentNotificationForPublished'] = sentNotificationForPublished;
    json['SocialMedialink'] = socialMediaLink;
    json['ArticleTitle'] = articleTitle;
    json['ShortDescription'] = shortDesc;
    return json;
  }
}
