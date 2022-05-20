import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_loading_screen_state.dart';

class ShowLoadingScreenCubit extends Cubit<ShowLoadingScreenState> {
  ShowLoadingScreenCubit() : super(ShowLoadingScreenState(showLoading: false));

  startLoading(bool val) {
    emit(state.copyWith(val));
  }
}
