import 'package:hive/hive.dart';
part 'hive_articles_comments.g.dart';

@HiveType(typeId: 2)
class HiveArticlesComments extends HiveObject {
  @HiveField(0)
  late String comment;
  @HiveField(1)
  late String commentTime;
  @HiveField(2)
  late String commentUid;
  @HiveField(3)
  late String commentName;
}
