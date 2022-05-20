import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveArticleSubtypeModel/hive_article_subtype_model.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/HiveBoxes/hive_boxes.dart';
import '/Journz_Large_Screen/NewHomePage/LocalDatabase/SubtypeNamePreferences/subtype_name_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_article_subtype_state.dart';

class GetArticleSubtypeCubit extends Cubit<GetArticleSubtypeState> {
  GetArticleSubtypeCubit() : super(GetArticleSubtypeState());

  addSubtypeToHiveDb() {
    SharedPreferences.getInstance().then((pref) async {
      Box<HiveArticlesSubtypes>? subTypeDataBox =
          Boxes.getArticleSubtypeFromCloud();

      List<String>? dummySubTypeList = [];
      List<String>? subTypeList =
          await SubtypeNamePreferences().retriveSubtypeName(pref);
      if (await subTypeList != null && await subTypeList != []) {
        //    print("subtype 1");
        if (subTypeList!.length == subTypeDataBox.length) {
          //  print("subtype 2");
          FirebaseFirestore.instance
              .collection('ArticleSubtype')
              .where('NoOfArticles', isGreaterThan: 0)
              .get()
              .then((value) {
            value.docs.forEach((e) async {
              if (subTypeList.contains(e.data()['SubType'])) {
              } else {
                dummySubTypeList.add(await e.data()['SubType']);
                SubtypeNamePreferences()
                    .storeSubtypeName(pref, dummySubTypeList);

                final data = HiveArticlesSubtypes()
                  ..subtypeName = await e.data()['SubType']
                  ..photoUrl = await e.data()['PhotoPath'];

                final box = Boxes.getArticleSubtypeFromCloud();

                box.add(data);
              }
            });
          });
        } else {
          //print("subtype 3");
          SubtypeNamePreferences().storeSubtypeName(pref, null);
          subTypeDataBox.clear();

          FirebaseFirestore.instance
              .collection('ArticleSubtype')
              .where('NoOfArticles', isGreaterThan: 0)
              .get()
              .then((value) {
            value.docs.forEach((element) async {
              dummySubTypeList.add(await element.data()['SubType']);

              SubtypeNamePreferences().storeSubtypeName(pref, dummySubTypeList);

              final data = HiveArticlesSubtypes()
                ..subtypeName = await element.data()['SubType']
                ..photoUrl = await element.data()['PhotoPath'];

              final box = Boxes.getArticleSubtypeFromCloud();

              box.add(data);
            });
          });
        }
      } else {
        //     print("subtype 4");
        subTypeDataBox.clear();

        FirebaseFirestore.instance
            .collection('ArticleSubtype')
            .where('NoOfArticles', isGreaterThan: 0)
            .get()
            .then((value) {
          value.docs.forEach((element) async {
            dummySubTypeList.add(await element.data()['SubType']);
            SubtypeNamePreferences().storeSubtypeName(pref, dummySubTypeList);

            final data = HiveArticlesSubtypes()
              ..subtypeName = await element.data()['SubType']
              ..photoUrl = await element.data()['PhotoPath'];

            final box = Boxes.getArticleSubtypeFromCloud();

            box.add(data);
          });
        });
      }
    });
  }
}


/*  final data = HiveArticlesSubtypes()
                  ..subtypeName = e.data()['SubType']
                  ..photoUrl = e.data()['PhotoPath'];

                subTypeDataBox.add(data); */