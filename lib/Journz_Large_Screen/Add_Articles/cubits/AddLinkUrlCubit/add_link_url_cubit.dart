import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_link_url_state.dart';

class AddLinkUrlCubit extends Cubit<AddLinkUrlState> {
  AddLinkUrlCubit() : super(AddLinkUrlState(isLinkTapped: false));

  getAddLinkResponse(bool data) {
    emit(state.copyWith(val: data));
  }
}
