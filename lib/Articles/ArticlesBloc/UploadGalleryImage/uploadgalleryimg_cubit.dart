import 'dart:io';

import 'package:bloc/bloc.dart';
import '/Articles/DataModel/GalleryFileModel.dart';
import '/Articles/DataModel/GallleryStringModel.dart';
import '/Articles/DataServices/ArticlesDatabase.dart';

part 'uploadgalleryimg_state.dart';

class UploadgalleryimgCubit extends Cubit<UploadgalleryimgState> {
  UploadgalleryimgCubit()
      : super(UploadgalleryimgState(galleryString: null, uploadTapped: false));

  uploadGalleryImage(
      {required bool tap,
      GalleryFileModel? file,
      List<Map<String, dynamic>>? imgUrl,
      String? bucket}) async {
    //List<String> imgUrl = [];
    emit(state.copyWith(uploadTap: tap));
    if (file != null && imgUrl != null && bucket != null) {
      imgUrl.add(GalleryStringModel(
              imgUrl: await getArticlePhotoUrl(file.file!, bucket),
              message: file.message)
          .toJson()); //await getArticlePhotoUrl(file.file!, bucket)
      print('nnnnn ga $imgUrl');
      emit(state.copyWith(str: imgUrl, uploadTap: tap));
    }
  }

  getArticlePhotoUrl(File _image, String subtype) async {
    String? photoUrl;
    bool photoUpload = false;
    print('nnn Subtype $subtype');
    if (subtype.isNotEmpty) {
      print('nnn fileimg $_image  str $subtype');
      photoUrl = await ArticlesDataBase().addPhotoForArticle(_image, subtype);
      print('nnn pho $photoUrl');
      photoUrl != null ? photoUpload = true : photoUpload = false;
      print('nnn final url $photoUrl');
    }
    return photoUrl;
  }
}
