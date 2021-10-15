import 'package:bloc/bloc.dart';

part 'tabbarindexchanger_state.dart';

class TabbarindexchangerCubit extends Cubit<TabbarindexchangerState> {
  TabbarindexchangerCubit() : super(TabbarindexchangerState(tabIndex: 0));

  getIndex(int val) {
    emit(state.copyWith(index: val));
  }
}
