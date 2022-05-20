part of 'leftpane_expansion_tile_cubit.dart';

class LeftpaneExpansionTileState {
  final String expandablePane;
  const LeftpaneExpansionTileState({required this.expandablePane});

  LeftpaneExpansionTileState copyWith(String section) {
    return LeftpaneExpansionTileState(expandablePane: section);
  }
}
