// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_article_subtype_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveArticlesSubtypesAdapter extends TypeAdapter<HiveArticlesSubtypes> {
  @override
  final int typeId = 1;

  @override
  HiveArticlesSubtypes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveArticlesSubtypes()
      ..subtypeName = fields[1] as String
      ..photoUrl = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, HiveArticlesSubtypes obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.subtypeName)
      ..writeByte(2)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveArticlesSubtypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
