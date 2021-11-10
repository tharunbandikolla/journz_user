import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

part 'loaddatapartbypart_state.dart';

class LoaddatapartbypartCubit extends Cubit<LoaddatapartbypartState> {
  LoaddatapartbypartCubit()
      : super(LoaddatapartbypartState(
            splitedData: null, lastDoc: null, docLength: null));
  int perPage = 15;
  getProducts(String userCountry) async {
    List<DocumentSnapshot> list = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .orderBy('CreatedTime', descending: true)
        .where('Country', arrayContainsAny: ['All', userCountry])
        .limit(perPage)
        .get();
    /* 
        .then((value) async {
          value.docs.forEach((element) async {
            if (element.data()['Country'] == userCountry ||
                element.data()['Country'] == "All") {
              list.add(element);
          
            }
          });
        }); */

    list = querySnapshot.docs;

    /* for (int m = 0; m <= list.length; m++) {
      if ((m + 1) % 5 == 0) {
        listContainAds.add(null);
      } else {
        listContainAds.add(list[m]);
      }

      print('nnn Ads Products $listContainAds  ${list.length}');
    } */
    //print('nnn Products ${list.length}');
    //DocumentSnapshot lastDoc =    querySnapshot.docs[querySnapshot.docs.length - 1];
    emit(state.copyWith(
        data: querySnapshot.docs,
        nos: querySnapshot.docs.length - 1,
        doc: querySnapshot.docs[querySnapshot.docs.length - 1]));
  }

  getMoreProducts(List<DocumentSnapshot> list, DocumentSnapshot lastDoc,
      BuildContext context, int docLength, String userCountry) async {
    print('nnn get more cubit called docLength $docLength');
    FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .orderBy('CreatedTime', descending: true)
        .startAfter([lastDoc.get('CreatedTime')])
        .limit(docLength <= perPage ? docLength : perPage)
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if (element.data()['Country'] == userCountry ||
                element.data()['Country'] == "All") {
              list.add(element);
              emit(state.copyWith(data: list, doc: element, nos: list.length));
            }
          });
        });

    //lastDoc = q.docs[q.docs.length - 1];

    //list.addAll(q.docs);
    // print('nnn products Added');
    // Future.delayed(Duration(seconds: 2), () {
    // });
    //}
  }
}
