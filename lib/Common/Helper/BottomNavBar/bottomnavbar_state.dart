part of 'bottomnavbar_cubit.dart';

class BottomnavbarState extends Equatable {
  int currentIndex;
  BottomnavbarState({required this.currentIndex});
  BottomnavbarState copyWith({int? index}) {
    return BottomnavbarState(currentIndex: index ?? this.currentIndex);
  }

  @override
  List<Object> get props => [currentIndex];
}
