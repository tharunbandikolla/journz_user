import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loadingscreen_state.dart';

class LoadingscreenCubit extends Cubit<LoadingscreenState> {
  LoadingscreenCubit() : super(LoadingscreenState(isNotLoading: true));

  changeLoadingState(bool loadingState) {
    emit(state.copyWith(loading: loadingState));
  }
}
