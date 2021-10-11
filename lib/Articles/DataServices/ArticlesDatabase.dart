import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as fireStorage;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ArticlesDataBase {
  getArticlesSubType() async {
    return FirebaseFirestore.instance.collection('ArticleSubtype').snapshots();
  }

  getAuthorDetails() async {
    return FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Future addPhotoForArticle(File _image, String subtype) async {
    String baseFileName = path.basename(_image.path);
    String? val;
    fireStorage.Reference ref;
    ref = fireStorage.FirebaseStorage.instance
        .ref()
        .child('Articles/$subtype/$baseFileName');

    await ref.putFile(_image).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        print('nnn db store img $value');
        val = value;
        print('nnn val store img $val');
      });
    });
    return val;
  }

  addArticleToDB(String docId, Map<String, dynamic> data) async {
//    var rng = new Random();
    //  var docid = rng.nextInt(999999999) * rng.nextInt(999999999);
    //var docId = 'A$docid';

    return await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docId)
        .set(data);
  }

  updateArticleInDB(String docid, Map<String, dynamic> data) async {
//    var rng = new Random();
    //  var docid = rng.nextInt(999999999) * rng.nextInt(999999999);
    //var docId = 'A$docid';

    return await FirebaseFirestore.instance
        .collection('ArticlesCollection')
        .doc(docid.toString())
        .update(data);
  }
}
