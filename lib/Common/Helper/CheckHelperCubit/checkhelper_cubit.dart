import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'checkhelper_state.dart';

/*class CheckhelperCubit extends Cubit<CheckhelperState> {
  CheckhelperCubit()
      : super(CheckhelperState(
            body: false,
            desc: false,
            error: false,
            title: false,
            state: false));

  getboolForField(String id) async {
    await FirebaseFirestore.instance
        .collection('CheckCollection')
        .doc(id)
        .get()
        .then((value) async {
      if (value.data()!.containsKey('title') &&
          value.data()!.containsKey('desc') &&
          value.data()!.containsKey('body') &&
          value.data()!.containsKey('error') &&
          value.data()!.containsKey('state')) {
        print('nnn state cubit route 1');
        emit(state.copyWith(
            title1: true,
            body1: true,
            desc1: true,
            error1: true,
            state1: true));
      } else if (value.data()!.containsKey('title') &&
          value.data()!.containsKey('desc') &&
          value.data()!.containsKey('body') &&
          value.data()!.containsKey('state')) {
        print('nnn state cubit route 2');
        emit(state.copyWith(
            title1: true,
            body1: true,
            desc1: true,
            error1: false,
            state1: true));
      } else if (value.data()!.containsKey('title') &&
          value.data()!.containsKey('desc') &&
          value.data()!.containsKey('body') &&
          value.data()!.containsKey('error')) {
        print('nnn state cubit route 3');
        emit(state.copyWith(
            title1: true,
            body1: true,
            desc1: true,
            error1: true,
            state1: false));
      } else if (value.data()!.containsKey('title') &&
          value.data()!.containsKey('desc') &&
          value.data()!.containsKey('body')) {
        print('nnn state cubit route 4');
        emit(state.copyWith(
            title1: true,
            body1: true,
            desc1: true,
            error1: false,
            state1: false));
      }
    });
  }
}*/

class CheckhelperCubit extends Cubit<CheckhelperState> {
  CheckhelperCubit() : super(CheckhelperState());

  getboolForField(String id) async {
    await FirebaseFirestore.instance
        .collection('CheckCollection')
        .doc(id)
        .get()
        .then((value) async {
      emit(state.copyWith(
          body1: await value.data()?['body'],
          desc1: await value.data()?['desc'],
          error1: await value.data()?['error'],
          state1: await value.data()?['state'],
          title1: await value.data()?['title']));
    });
  }
}
