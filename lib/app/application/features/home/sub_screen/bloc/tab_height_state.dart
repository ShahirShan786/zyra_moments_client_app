part of 'tab_height_bloc.dart';

class TabHeightState {
  final List<double> tabHeights;
  final int currentTabIndex;
  final double currentHeight;

  TabHeightState({
    required this.tabHeights,
    required this.currentTabIndex,
    required this.currentHeight,
  });

  factory TabHeightState.initial(int tabCount) {
    List<double> heights = List.filled(tabCount, 500.0);
    return TabHeightState(
      tabHeights: heights,
      currentTabIndex: 0,
      currentHeight: 500.0,
    );
  }

  TabHeightState copyWith({
    List<double>? tabHeights,
    int? currentTabIndex,
    double? currentHeight,
  }) {
    return TabHeightState(
      tabHeights: tabHeights ?? this.tabHeights,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      currentHeight: currentHeight ?? this.currentHeight,
    );
  }
}
