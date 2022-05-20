part of 'notificationonoff_cubit.dart';

class NotificationonoffState {
  String notificationState;
  NotificationonoffState({required this.notificationState});

  NotificationonoffState copyWith(String data) {
    return NotificationonoffState(notificationState: data);
  }
}
