part of 'show_loading_screen_cubit.dart';

class ShowLoadingScreenState {
  final bool showLoading;
  ShowLoadingScreenState({required this.showLoading});

  ShowLoadingScreenState copyWith(bool data) {
    return ShowLoadingScreenState(showLoading: data);
  }
}
