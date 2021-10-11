part of 'getgalleryfile_cubit.dart';

class GetgalleryfileState {
  File? file;
  GetgalleryfileState({this.file});

  GetgalleryfileState copyWith({File? f}) {
    return GetgalleryfileState(file: f ?? this.file);
  }
}
