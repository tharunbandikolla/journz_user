part of 'favouriteselectiondialogbox_cubit.dart';

class FavouriteselectiondialogboxState {
  bool? val;
  List? favouriteList;
  FavouriteselectiondialogboxState({this.val, this.favouriteList});

  FavouriteselectiondialogboxState copyWith({bool? v, List? tapList}) {
    return FavouriteselectiondialogboxState(
        val: v ?? this.val, favouriteList: tapList ?? this.favouriteList);
  }
}
