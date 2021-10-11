import 'package:bloc/bloc.dart';
import '/Articles/DataModel/GalleryFileModel.dart';
part 'galleryphoto_state.dart';

class GalleryphotoCubit extends Cubit<GalleryphotoState> {
  GalleryphotoCubit() : super(GalleryphotoState(photo: null));

  getImageForGallery(Map<String, dynamic>? imgData,
      List<GalleryFileModel>? galleryModel) async {
    // final pickedFile = await getImage();
//    List<File> imgFiles = [];
    if (imgData != null) {
      galleryModel!.add(
        GalleryFileModel(
            file: imgData['imageFile'], message: imgData['message']),
      ); //File(pickedFile!.path)
      emit(state.copyWith(img: galleryModel));
    } else {
      emit(state.copyWith(img: []));
    }
  }

  removeImage(List<GalleryFileModel> file, int index) {
    file.removeAt(index);
    emit(state.copyWith(img: file));
  }
}
