part of 'bookmarkarticles_cubit.dart';

class BookmarkarticlesState {
  bool isBookmarked = false;
  BookmarkarticlesState({required this.isBookmarked});

  BookmarkarticlesState copyWith(bool data) {
    return BookmarkarticlesState(isBookmarked: data);
  }
}
