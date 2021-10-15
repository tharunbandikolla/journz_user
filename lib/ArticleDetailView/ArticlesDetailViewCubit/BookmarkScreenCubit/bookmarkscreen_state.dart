part of 'bookmarkscreen_cubit.dart';

class BookmarkscreenState extends Equatable {
  Stream bookmarkStream;
  BookmarkscreenState({required this.bookmarkStream});

  BookmarkscreenState copyWith({Stream? stream}) {
    return BookmarkscreenState(bookmarkStream: stream ?? this.bookmarkStream);
  }

  @override
  List<Object> get props => [bookmarkStream];
}
