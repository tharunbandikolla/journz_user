part of 'bookmarkcubit_cubit.dart';

class BookmarkcubitState extends Equatable {
  bool isBookmarked;
  BookmarkcubitState({required this.isBookmarked});
  BookmarkcubitState copyWith({bool? bookmark}) {
    return BookmarkcubitState(isBookmarked: bookmark!);
  }

  @override
  List<Object> get props => [isBookmarked];
}
