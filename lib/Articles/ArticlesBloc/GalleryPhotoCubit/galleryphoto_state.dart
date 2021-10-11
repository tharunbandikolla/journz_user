part of 'galleryphoto_cubit.dart';

class GalleryphotoState {
  List<GalleryFileModel>? photo;
  GalleryphotoState({this.photo});

  GalleryphotoState copyWith({List<GalleryFileModel>? img}) {
    return GalleryphotoState(photo: img ?? this.photo);
  }
}
