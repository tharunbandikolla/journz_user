import 'dart:io';

import 'package:bloc/bloc.dart';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart' as fb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
part 'addphototoarticle_state.dart';

class AddphotoarticleCubit extends Cubit<AddphotoarticleState> {
  BuildContext? context;
  XFile? photoFile;
  File? fileImg;
  String? photoUrl;
  bool? photoUpload;
  AddphotoarticleCubit()
      : super(AddphotoarticleState(
            photoURL: 'WithoutImage',
            articlePhotoFile: null,
            isPhotoUploaded: false));
  void givePhotoUrl(String url, bool isUploaded) {
    emit(state.copyWith(hasPhotoUploaded: isUploaded, photourl: url));
  }

  void uploadImage({required Function(html.File file) onSelected}) {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement()
      ..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  Future uploadToStorage(String subtype) async {
    uploadImage(onSelected: (file) async {
      final path = 'Catgories/$subtype';
      fb.Reference ref;
      ref = fb.FirebaseStorage.instance
          .ref() //'gs://fluenzo-1992.appspot.com/'
          .child(path);
      await ref.putBlob(file).whenComplete(() {
        ref.getDownloadURL().then((value) {
          emit(state.copyWith(
              filePic: file, photourl: value, hasPhotoUploaded: true));
        });
      });
    });
  }

  closeSelectedPhoto() {
    emit(
        state.copyWith(filePic: null, photourl: null, hasPhotoUploaded: false));
  }
}
