part of 'loadingscreen_cubit.dart';

class LoadingscreenState extends Equatable {
  bool isNotLoading = true;
  LoadingscreenState({required this.isNotLoading});
  LoadingscreenState copyWith({bool? loading}) {
    return LoadingscreenState(isNotLoading: loading ?? this.isNotLoading);
  }

  @override
  List<Object> get props => [isNotLoading];
}
