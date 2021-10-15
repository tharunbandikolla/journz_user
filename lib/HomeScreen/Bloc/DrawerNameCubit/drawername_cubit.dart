import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/HomeScreen/DataService/ArticleDatabase.dart';

part 'drawername_state.dart';

class DrawernameCubit extends Cubit<DrawernameState> {
  DrawernameCubit()
      : super(DrawernameState(
            photoUrl: 'images/fluenzologo.png',
            role: "User",
            drawerEmail: 'Fluenzo2020@gmail.com',
            drawerName: 'Fluenzo'));

  getDrawerNameAndEmail() async {
    String? appUserName, appUserEmail, role, photo;
    if (FirebaseAuth.instance.currentUser != null) {
      await ArticleDatabase().getAppUserDetails().then((value) async {
        appUserEmail = await value.data()['Email'];
        appUserName = await value.data()['Name'];
        role = await value.data()['Role'];
        photo = await value.data()['PhotoUrl'];

        emit(state.copyWith(
            name: appUserName, photo: photo, email: appUserEmail, role: role));
      });
    }
    //Future.delayed(Duration(milliseconds: 500), () {

    // });
  }
}
