import 'package:hive/hive.dart';
part 'hive_article_data.g.dart';

@HiveType(typeId: 0)
class HiveArticleData extends HiveObject {
  @HiveField(01)
  late String articleDescription;
  @HiveField(02)
  late List<dynamic> articleLike;
  @HiveField(03)
  late String articlePhotoUrl;
  @HiveField(04)
  late List<dynamic> articleReportedBy;
  @HiveField(05)
  late String? articleSubtype;
  @HiveField(06)
  late String? articleTitle;
  @HiveField(07)
  late String? authorName;
  @HiveField(08)
  late String? authorUid;
  @HiveField(09)
  late List<dynamic> bookmarkedBy;
  @HiveField(10)
  late List<dynamic> country;
  @HiveField(11)
  late String documentId;
  @HiveField(12)
  late List<dynamic> galleryImages;
  @HiveField(13)
  late String isArticlePublished;
  @HiveField(14)
  late String isArticleReported;
  @HiveField(15)
  late int noOflikes;
  @HiveField(16)
  late int noOfViews;
  @HiveField(17)
  late int noOfComments;
  @HiveField(18)
  late String socialMediaLink;
  @HiveField(19)
  late String shortDescription;
}
