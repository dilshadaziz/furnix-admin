part of 'side_menu_bar_bloc.dart';

sealed class SideMenuBarState extends Equatable {
  const SideMenuBarState();
  
  @override
  List<Object> get props => [];
}

final class SideMenuBarInitial extends SideMenuBarState {}

final class SideMenuBarItemSelectedState extends SideMenuBarState{
  final int selectedIndex;
  const SideMenuBarItemSelectedState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}

final class SideMenuBarItemHoveredState extends SideMenuBarState{
  final int hoverIndex;

  const SideMenuBarItemHoveredState({required this.hoverIndex});

  @override
  List<Object> get props => [hoverIndex];
}