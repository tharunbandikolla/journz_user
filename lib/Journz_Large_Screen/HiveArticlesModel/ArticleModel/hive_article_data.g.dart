// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_article_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveArticleDataAdapter extends TypeAdapter<HiveArticleData> {
  @override
  final int typeId = 0;

  @override
  HiveArticleData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveArticleData()
      ..articleDescription = fields[1] as String
      ..articleLike = (fields[2] as List).cast<dynamic>()
      ..articlePhotoUrl = fields[3] as String
      ..articleReportedBy = (fields[4] as List).cast<dynamic>()
      ..articleSubtype = fields[5] as String?
      ..articleTitle = fields[6] as String?
      ..authorName = fields[7] as String?
      ..authorUid = fields[8] as String?
      ..bookmarkedBy = (fields[9] as List).cast<dynamic>()
      ..country = (fields[10] as List).cast<dynamic>()
      ..documentId = fields[11] as String
      ..galleryImages = (fields[12] as List).cast<dynamic>()
      ..isArticlePublished = fields[13] as String
      ..isArticleReported = fields[14] as String
      ..noOflikes = fields[15] as int
      ..noOfViews = fields[16] as int
      ..noOfComments = fields[17] as int
      ..socialMediaLink = fields[18] as String
      ..shortDescription = fields[19] as String;
  }

  @override
  void write(BinaryWriter writer, HiveArticleData obj) {
    writer
      ..writeByte(19)
      ..writeByte(1)
      ..write(obj.articleDescription)
      ..writeByte(2)
      ..write(obj.articleLike)
      ..writeByte(3)
      ..write(obj.articlePhotoUrl)
      ..writeByte(4)
      ..write(obj.articleReportedBy)
      ..writeByte(5)
      ..write(obj.articleSubtype)
      ..writeByte(6)
      ..write(obj.articleTitle)
      ..writeByte(7)
      ..write(obj.authorName)
      ..writeByte(8)
      ..write(obj.authorUid)
      ..writeByte(9)
      ..write(obj.bookmarkedBy)
      ..writeByte(10)
      ..write(obj.country)
      ..writeByte(11)
      ..write(obj.documentId)
      ..writeByte(12)
      ..write(obj.galleryImages)
      ..writeByte(13)
      ..write(obj.isArticlePublished)
      ..writeByte(14)
      ..write(obj.isArticleReported)
      ..writeByte(15)
      ..write(obj.noOflikes)
      ..writeByte(16)
      ..write(obj.noOfViews)
      ..writeByte(17)
      ..write(obj.noOfComments)
      ..writeByte(18)
      ..write(obj.socialMediaLink)
      ..writeByte(19)
      ..write(obj.shortDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveArticleDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
