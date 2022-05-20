part of 'addphototoarticle_cubit.dart';

class AddphotoarticleState {
  html.File? articlePhotoFile;
  String? photoURL;
  bool? isPhotoUploaded;
  AddphotoarticleState(
      {this.articlePhotoFile, this.photoURL, this.isPhotoUploaded});

  AddphotoarticleState copyWith(
      {html.File? filePic, String? photourl, bool? hasPhotoUploaded}) {
    print('nnn bui state $filePic  $photourl');
    return AddphotoarticleState(
        articlePhotoFile: filePic,
        photoURL: photourl,
        isPhotoUploaded: hasPhotoUploaded);
  }
}
