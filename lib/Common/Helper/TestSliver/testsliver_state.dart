part of 'testsliver_cubit.dart';

class TestsliverState {
  int? photoUrl;
  String? all;
  TestsliverState({this.photoUrl, this.all});

  TestsliverState copyWith({int? photo, String? a}) {
    return TestsliverState(
        photoUrl: photo ?? this.photoUrl, all: a ?? this.all);
  }
}
