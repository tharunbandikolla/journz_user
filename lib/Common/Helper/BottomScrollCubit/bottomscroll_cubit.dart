import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomscroll_state.dart';

class BottomscrollCubit extends Cubit<BottomscrollState> {
  BottomscrollCubit() : super(BottomscrollState(scrollDown: true));

  //void myScroll(ScrollController scrollBottomBarController) async {
  // scrollBottomBarController.addListener(() {
  //  print('nnn bo scroll listen');
  // if (scrollBottomBarController.position.userScrollDirection ==
  //    ScrollDirection.reverse) {
  // if (!isScrollingDown) {
  //  state.copyWith(scroll: true);
  // }
  //}
  // if (scrollBottomBarController.position.userScrollDirection ==
  //    ScrollDirection.forward) {
  // if (isScrollingDown) {
  //  state.copyWith(scroll: false);
  //}
  // }
  ///   });
  // }

  void setScrollFalse() {
    print('nnn bo false');
    state.copyWith(scroll: false);
  }

  void setScrollTrue() {
    print('nnn bo reue');
    state.copyWith(scroll: true);
  }
}
