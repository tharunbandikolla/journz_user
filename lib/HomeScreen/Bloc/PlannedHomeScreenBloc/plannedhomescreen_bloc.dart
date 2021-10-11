import 'package:Journz/HomeScreen/DataModel/ArticlesSubtypeModel.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'plannedhomescreen_event.dart';
part 'plannedhomescreen_state.dart';

class PlannedhomescreenBloc
    extends Bloc<PlannedhomescreenEvent, PlannedhomescreenState> {
  List<ArticlesSubtypeModel> currentSubTypeList = [];

  int perPage = 15;

  List<dynamic>? userFavouriteCategoryListFromDB = [];

  PlannedhomescreenBloc(PlannedhomescreenState initialState)
      : super(initialState);

  @override
  Stream<PlannedhomescreenState> mapEventToState(
      PlannedhomescreenEvent event) async* {
    if (event is GetArticleSubtypeForHomeScreen) {
      FirebaseFirestore.instance
          .collection('ArticleSubtype')
          .get()
          .then((value) async {
        value.docs.forEach((element) async {
          if (await element.data()['NoOfArticles'] > 0) {
            currentSubTypeList.add(ArticlesSubtypeModel(
                subTypeName: await element.data()['SubType'],
                photoUrl: await element.data()['PhotoPath']));

            print('nnn current list ${currentSubTypeList[0].photoUrl}');
          }
        });
      });
      yield ShowArticleSubtypeState(SubTypeList: currentSubTypeList);
      if (FirebaseAuth.instance.currentUser != null) {
        yield* request();
      }
    } else if (event is GetArticleForHomeScreen) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ArticlesCollection')
          .orderBy('CreatedTime', descending: true)
          .limit(perPage)
          .get();

      List<DocumentSnapshot> list = querySnapshot.docs;
      DocumentSnapshot lastDoc =
          querySnapshot.docs[querySnapshot.docs.length - 1];
      /* emit(state.copyWith(
        data: querySnapshot.docs,
        nos: querySnapshot.docs.length - 1,
        doc: querySnapshot.docs[querySnapshot.docs.length - 1]));
    } */
      yield ShowArticleState(
          articleSubtypeList: event.articleSubtypeList,
          docLength: querySnapshot.docs.length - 1,
          lastDoc: querySnapshot.docs[querySnapshot.docs.length - 1],
          splitedData: querySnapshot.docs);
    } else if (event is GetFavouriteArticleForHomeScreen) {
      yield ShowFavouriteArticleState(
          article: event.article,
          docLength: event.docLength,
          lastdoc: event.lastdoc,
          subtype: event.subtype,
          favouriteArticle: userFavouriteCategoryListFromDB);
    }
  }

  Stream<PlannedhomescreenState> request() async* {
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(id)
        .get()
        .then((value) async {
      print(
          'nnn fav category ${await value.data()!['UsersFavouriteArticleCategory']}');
      userFavouriteCategoryListFromDB =
          await value.data()?['UsersFavouriteArticleCategory'] ?? [];
    });
  }
}
