import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'notificationonoff_state.dart';

class NotificationonoffCubit extends Cubit<NotificationonoffState> {
  NotificationonoffCubit()
      : super(
            NotificationonoffState(notificationState: "Disable Notification"));

  toggleNotification(String uid) {
    FirebaseFirestore.instance
        .collection("UserProfile")
        .doc(uid)
        .get()
        .then((value) {
      if (value.data()!["WebNotificationToken"] == "Disable Notification") {
        emit(state.copyWith("Enable Notification"));
      } else {
        emit(state.copyWith("Disable Notification"));
      }
    });
  }
}
