part of 'tabbarindexchanger_cubit.dart';

class TabbarindexchangerState {
  int? tabIndex;
  TabbarindexchangerState({this.tabIndex});

  TabbarindexchangerState copyWith({int? index}) {
    return TabbarindexchangerState(tabIndex: index ?? this.tabIndex);
  }
}
