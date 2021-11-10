import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityState(connectivity: true));

  getConnectionState(bool conn) {
    print('nnn conn cubit $conn');
    emit(state.copyWith(connection: conn));
  }
}
