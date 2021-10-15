import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/HomeScreen/DataService/ArticleDatabase.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  Stream? articleDataStream, subtypeDataStream;
  String? selectedSubtype;
  ArticleCubit()
      : super(ArticleState(
            articleStream: ArticleDatabase().getArticleStream(),
            articleSubtype: ArticleDatabase().getArticleSubtype(),
            subType: 'All'));

  getDataForArticleSection(String changeSubtype) async {
    print('nnn change $changeSubtype');
    articleDataStream = await ArticleDatabase().getArticleStream();
    subtypeDataStream = await ArticleDatabase().getArticleSubtype();

    emit(state.copyWith(
        articleStream: articleDataStream,
        subTypeStream: subtypeDataStream,
        subtypeString: changeSubtype));
  }
}
