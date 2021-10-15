part of 'uploadgalleryimg_cubit.dart';

class UploadgalleryimgState {
  List<Map<String, dynamic>>? galleryString;
  bool? uploadTapped;
  UploadgalleryimgState({this.galleryString, this.uploadTapped});

  UploadgalleryimgState copyWith(
      {List<Map<String, dynamic>>? str, bool? uploadTap}) {
    return UploadgalleryimgState(
        galleryString: str ?? this.galleryString,
        uploadTapped: uploadTap ?? this.uploadTapped);
  }
}
