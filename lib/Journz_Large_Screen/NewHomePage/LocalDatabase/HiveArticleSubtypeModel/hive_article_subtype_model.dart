import 'package:hive/hive.dart';
part 'hive_article_subtype_model.g.dart';

@HiveType(typeId: 1)
class HiveArticlesSubtypes extends HiveObject {
  @HiveField(01)
  late String subtypeName;
  @HiveField(02)
  late String photoUrl;
}
