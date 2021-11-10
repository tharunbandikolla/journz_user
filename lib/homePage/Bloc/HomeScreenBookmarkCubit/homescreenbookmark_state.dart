part of 'homescreenbookmark_cubit.dart';

class HomescreenbookmarkState extends Equatable {
  bool isBookmarked;
  HomescreenbookmarkState({required this.isBookmarked});
  HomescreenbookmarkState copyWith({bool? bookmark}) {
    return HomescreenbookmarkState(isBookmarked: bookmark!);
  }

  @override
  List<Object> get props => [isBookmarked];
}
