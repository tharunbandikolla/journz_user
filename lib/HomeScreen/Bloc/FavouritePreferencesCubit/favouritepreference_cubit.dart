import 'package:Journz/HomeScreen/Helper/FavArticleSharedPreferences.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favouritepreference_state.dart';

class FavouritepreferenceCubit extends Cubit<FavouritepreferenceState> {
  FavouritepreferenceCubit()
      : super(FavouritepreferenceState(locFavCategory: ['Mindset']));
  List<String>? locFav = [];
  getFavCategoryFromPref(SharedPreferences? pref) async {
    var p = await SharedPreferences.getInstance();
    locFav = await FavArticleSharedPreferences().getFavCategories(pref ?? p);
    emit(state.copyWith(listStr: locFav!));
  }
}
