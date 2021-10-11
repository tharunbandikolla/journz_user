import 'dart:io';
import 'package:bloc/bloc.dart';
import '/Articles/DataServices/ArticlesDatabase.dart';
import '/Common/Helper/AddPhotoToDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'addphototoarticle_state.dart';

class AddphotoarticleCubit extends Cubit<AddphotoarticleState> {
  BuildContext? context;
  File? photoFile;
  String? photoUrl;
  bool? photoUpload;
  AddphotoarticleCubit()
      : super(AddphotoarticleState(
            photoURL: null, articlePhotoFile: null, isPhotoUploaded: false));

  getPhoto(String subType, {required BuildContext ctx}) async {
    this.context = ctx;
    photoFile = await getImage();

    print('nnn photofile $photoFile');
    getArticlePhotoUrl(photoFile!, subType);
  }

  getArticlePhotoUrl(File _image, String subtype) async {
    print('nnn Subtype $subtype');
    if (subtype.isNotEmpty) {
      print('nnn fileimg $_image  str $subtype');
      photoUrl = await ArticlesDataBase().addPhotoForArticle(_image, subtype);
      print('nnn pho $photoUrl');
      photoUrl != null ? photoUpload = true : photoUpload = false;
      print('nnn final url $photoUrl');
      emit(state.copyWith(
          filePic: _image, photourl: photoUrl, hasPhotoUploaded: photoUpload));
    }
  }

  closeSelectedPhoto() {
    emit(
        state.copyWith(filePic: null, photourl: null, hasPhotoUploaded: false));
  }
}
