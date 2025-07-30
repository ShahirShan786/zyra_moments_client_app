part of 'tab_height_bloc.dart';

abstract class TabHeightEvent {}

class UpdateTabHeightEvent extends TabHeightEvent {
  final int tabIndex;
  final double height;

  UpdateTabHeightEvent({required this.tabIndex, required this.height});
}

class ChangeTabEvent extends TabHeightEvent {
  final int tabIndex;

  ChangeTabEvent({required this.tabIndex});
}