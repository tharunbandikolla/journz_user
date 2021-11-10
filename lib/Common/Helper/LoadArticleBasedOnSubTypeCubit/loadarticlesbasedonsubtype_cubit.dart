import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'loadarticlesbasedonsubtype_state.dart';

class LoadarticlesbasedonsubtypeCubit
    extends Cubit<LoadarticlesbasedonsubtypeState> {
  LoadarticlesbasedonsubtypeCubit() : super(LoadarticlesbasedonsubtypeState());
  int s = 0;
  passDataBasedonCategory(String category, List<DocumentSnapshot> articleData,
      List<dynamic>? favCategory) async {
    if (category == "All") {
      print('nnn data now $category  And $articleData');
      emit(state.copyWith(cat: category, articlesData: articleData));
    } else if (category == 'Favourites') {
      /* fav = await FavArticleSharedPreferences()
          .getFavCategories(await SharedPreferences.getInstance()); */
      print('nnn entered into fav');
      List<DocumentSnapshot> data = [];
      for (DocumentSnapshot k in articleData) {
        if (favCategory != null) {
          /*
        while ((s - 1) >= 0) { */
          if (favCategory.contains(k.get('ArticleSubType'))) {
            print('nnn entered boom');
            data.add(k);

            print('nnn me ${data.length}');
            emit(state.copyWith(cat: category, articlesData: data));
          } else {
            emit(state.copyWith(cat: category, articlesData: data));
          }
        }
      }
      /* else {
        emit(state.copyWith(cat: category, articlesData: []));
      } */
    } else {
      List<DocumentSnapshot> data = [];
      for (DocumentSnapshot m in articleData) {
        if (m.get('ArticleSubType') == category) {
          data.add(m);
          emit(state.copyWith(cat: category, articlesData: data));
        }
      }
    }
  }
}
