import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

part 'loaddatapartbypart_state.dart';

class LoaddatapartbypartCubit extends Cubit<LoaddatapartbypartState> {
  LoaddatapartbypartCubit()
      : super(LoaddatapartbypartState(
            splitedData: null, lastDoc: null, docLength: null));
  int perPage = 15;
  getProducts() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .orderBy('CreatedTime', descending: true)
        .limit(perPage)
        .get();

    List<DocumentSnapshot> list = querySnapshot.docs;
    List<dynamic> listContainAds = [];
    /* for (int m = 0; m <= list.length; m++) {
      if ((m + 1) % 5 == 0) {
        listContainAds.add(null);
      } else {
        listContainAds.add(list[m]);
      }

      print('nnn Ads Products $listContainAds  ${list.length}');
    } */
    //print('nnn Products ${list.length}');
    DocumentSnapshot lastDoc =
        querySnapshot.docs[querySnapshot.docs.length - 1];
    emit(state.copyWith(
        data: querySnapshot.docs,
        nos: querySnapshot.docs.length - 1,
        doc: querySnapshot.docs[querySnapshot.docs.length - 1]));
  }

  getMoreProducts(List<DocumentSnapshot> list, DocumentSnapshot lastDoc,
      BuildContext context, int docLength) async {
    print('nnn get more cubit called docLength $docLength');
    //getMoreProducts();
    if (docLength >= perPage) {
      Query qu = FirebaseFirestore.instance
          .collection('ArticlesCollection')
          .orderBy('CreatedTime', descending: true)
          .startAfter([lastDoc.get('CreatedTime')]).limit(
              docLength <= perPage ? docLength : perPage);
      QuerySnapshot q = await qu.get();

      lastDoc = q.docs[q.docs.length - 1];

      list.addAll(q.docs);
      print('nnn products Added');
      Future.delayed(Duration(seconds: 2), () {
        emit(state.copyWith(data: list, doc: lastDoc, nos: q.docs.length));
      });
    }
  }
}
