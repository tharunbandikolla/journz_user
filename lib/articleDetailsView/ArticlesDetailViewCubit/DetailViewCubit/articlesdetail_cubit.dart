import 'package:bloc/bloc.dart';
import 'package:journz_web/articleDetailsView/DataService/ArticlesDetailViewDB.dart';


part 'articlesdetail_state.dart';

class ArticlesdetailCubit extends Cubit<ArticlesdetailState> {
  Stream? articleStream;
  ArticlesdetailCubit()
      : super(ArticlesdetailState(
            articlesDetailStream: null, title: 'Loading...'));

  getArticleDetail(String docid) async {
    articleStream =
        await ArticleDetailViewDB().getArticlesDetailViewStream(docid);
    String? articleTitle;
    ArticleDetailViewDB()
        .getArticlesDetailViewStream(docid)
        .listen((event) async {
      articleTitle = await event.data()['ArticleTitle'];
    });
    Future.delayed(Duration(milliseconds: 200), () {
      emit(state.copyWith(detailStream: articleStream, t: articleTitle));
    });
  }
}
