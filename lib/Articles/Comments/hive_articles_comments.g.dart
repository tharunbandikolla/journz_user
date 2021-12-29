// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_articles_comments.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveArticlesCommentsAdapter extends TypeAdapter<HiveArticlesComments> {
  @override
  final int typeId = 2;

  @override
  HiveArticlesComments read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveArticlesComments()
      ..comment = fields[0] as String
      ..commentTime = fields[1] as String
      ..commentUid = fields[2] as String
      ..commentName = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, HiveArticlesComments obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.comment)
      ..writeByte(1)
      ..write(obj.commentTime)
      ..writeByte(2)
      ..write(obj.commentUid)
      ..writeByte(3)
      ..write(obj.commentName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveArticlesCommentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
