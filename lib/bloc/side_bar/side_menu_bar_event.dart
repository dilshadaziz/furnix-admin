part of 'side_menu_bar_bloc.dart';

sealed class SideMenuBarEvent extends Equatable {
  const SideMenuBarEvent();

  @override
  List<Object> get props => [];
}


class SideMenuBarItemSelected extends SideMenuBarEvent{
  final int index;

  const SideMenuBarItemSelected({required this.index});

  @override
  List<Object> get props => [index];
}

class SideMenuBarItemHovered extends SideMenuBarEvent{
  final int index;

  const SideMenuBarItemHovered({required this.index});
  @override
  List<Object> get props => [index];
}
