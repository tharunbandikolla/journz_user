part of 'connectivity_cubit.dart';

class ConnectivityState extends Equatable {
  bool? connectivity;
  ConnectivityState({required this.connectivity});

  ConnectivityState copyWith({required bool connection}) {
    return ConnectivityState(connectivity: connection);
  }

  @override
  List<Object> get props => [];
}
