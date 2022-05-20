import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
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

  Future addPhotoForArticle1(File _image, String subtype) async {
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

  Future addPhotoForArticle(File? _image, String subtype) async {
    String baseFileName = path.basename(_image!.path);
    if (kIsWeb) {
      fireStorage.Reference ref;
      print('nnn 1 base name $baseFileName');
      ref = fireStorage.FirebaseStorage.instance.ref().child('images/navi');
      print('nnn 2 base name $baseFileName');
      await ref
          .putData(await _image.readAsBytes(),
              fireStorage.SettableMetadata(contentType: 'image/jpeg'))
          .whenComplete(() async {
        print('nnn 3 base name $baseFileName');
        await ref.getDownloadURL().then((value) {
          print('nnn base output $value');
          return value;
        });
      });
    } else {
//write a code for android or ios
    }
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
