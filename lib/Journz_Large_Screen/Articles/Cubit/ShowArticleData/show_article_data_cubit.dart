import 'package:bloc/bloc.dart';
import '/Journz_Large_Screen/HiveArticlesModel/ArticleModel/hive_article_data.dart';

part 'show_article_data_state.dart';

class ShowArticleDataCubit extends Cubit<ShowArticleDataState> {
  ShowArticleDataCubit() : super(ShowArticleDataState(hiveArticleData: null));

  passArticleData(HiveArticleData data) {
    emit(state.copyWith(data));
  }
}
