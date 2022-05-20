import 'package:bloc/bloc.dart';

part 'leftpane_expansion_tile_state.dart';

class LeftpaneExpansionTileCubit extends Cubit<LeftpaneExpansionTileState> {
  LeftpaneExpansionTileCubit()
      : super(LeftpaneExpansionTileState(expandablePane: "Articles"));

  whatSection(String section) {
    emit(state.copyWith(section));
  }
}
