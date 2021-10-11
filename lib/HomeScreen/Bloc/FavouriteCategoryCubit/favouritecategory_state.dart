part of 'favouritecategory_cubit.dart';

class FavouritecategoryState extends Equatable {
  List<String>? favCategory;
  FavouritecategoryState({this.favCategory});

  FavouritecategoryState copyWith({List<String>? str}) {
    return FavouritecategoryState(favCategory: str ?? this.favCategory);
  }

  @override
  List<Object> get props => [favCategory ?? 'All'];
}
