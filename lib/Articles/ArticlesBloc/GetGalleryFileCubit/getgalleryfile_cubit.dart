import 'dart:io';
import 'package:bloc/bloc.dart';
import '/Common/Helper/AddPhotoToDatabase.dart';

part 'getgalleryfile_state.dart';

class GetgalleryfileCubit extends Cubit<GetgalleryfileState> {
  GetgalleryfileCubit() : super(GetgalleryfileState(file: null));

  getPhoto() async {
    final pickedFile = await getImage();
    emit(state.copyWith(f: File(pickedFile.path)));
  }
}
