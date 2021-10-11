import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/ArticleDetailView/DataService/ArticlesDetailViewDB.dart';

part 'articletitle_state.dart';

class ArticletitleCubit extends Cubit<ArticletitleState> {
  ArticletitleCubit() : super(ArticletitleState(title: 'Loading...'));

  getTitle(String id) {
    String title = 'Loading...';
    ArticleDetailViewDB().getArticlesTitle(id).then((value) async {
      print('title ${value.data()!['ArticleTitle']}');
      title = await value.data()!['ArticleTitle'];
    });
    Future.delayed(Duration(milliseconds: 600), () {
      emit(state.copyWith(t: title));
    });
  }
}
