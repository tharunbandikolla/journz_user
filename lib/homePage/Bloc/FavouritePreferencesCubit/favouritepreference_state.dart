part of 'favouritepreference_cubit.dart';

class FavouritepreferenceState {
  List<String>? locFavCategory;
  FavouritepreferenceState({this.locFavCategory});

  FavouritepreferenceState copyWith({required List<String> listStr}) {
    return FavouritepreferenceState(locFavCategory: listStr);
  }
}
