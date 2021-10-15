part of 'bottomscroll_cubit.dart';

class BottomscrollState extends Equatable {
  bool scrollDown = false;
  BottomscrollState({required this.scrollDown});
  BottomscrollState copyWith({bool? scroll}) {
    return BottomscrollState(scrollDown: scroll ?? this.scrollDown);
  }

  @override
  List<Object> get props => [scrollDown];
}
