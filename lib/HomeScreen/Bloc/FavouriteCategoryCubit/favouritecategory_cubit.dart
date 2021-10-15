import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'favouritecategory_state.dart';

class FavouritecategoryCubit extends Cubit<FavouritecategoryState> {
  FavouritecategoryCubit() : super(FavouritecategoryState(favCategory: []));
  List<String> favCategories = [];
  getFavCategories() async {
    FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('UserFavouriteArticlesCategory')
        .snapshots()
        .listen((value) {
      value.docs.forEach((element) async {
        favCategories.add(await element.data()['Category'].toString());
        print('nnn fav $favCategories');

        emit(state.copyWith(str: favCategories));
      });
    });
  }

  removeFavCategories(String category) async {
    print('nnn fav categories $favCategories');
    favCategories.removeWhere((element) => element == category);
    print('nnn fav categories $favCategories');
    emit(state.copyWith(str: favCategories));
  }
}
