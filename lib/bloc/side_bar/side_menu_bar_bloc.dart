import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'side_menu_bar_event.dart';
part 'side_menu_bar_state.dart';

class SideMenuBarBloc extends Bloc<SideMenuBarEvent, SideMenuBarState> {
  SideMenuBarBloc() : super(SideMenuBarInitial()) {
    on<SideMenuBarItemSelected>(_onItemSelected);
    on<SideMenuBarItemHovered>(_onItemHovered);
  }
  void _onItemSelected(
      SideMenuBarItemSelected event, Emitter<SideMenuBarState> emit) {
    emit(SideMenuBarItemSelectedState(selectedIndex: event.index));
  }


  void _onItemHovered(SideMenuBarItemHovered event, Emitter<SideMenuBarState> emit){
    emit(SideMenuBarItemHoveredState(hoverIndex:event.index));
  }
}
