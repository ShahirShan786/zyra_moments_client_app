import 'package:bloc/bloc.dart';

part 'tab_height_event.dart';
part 'tab_height_state.dart';

class TabHeightBloc extends Bloc<TabHeightEvent, TabHeightState> {
  TabHeightBloc(int tabCount) : super(TabHeightState.initial(tabCount)) {
    on<UpdateTabHeightEvent>(_onUpdateTabHeight);
    on<ChangeTabEvent>(_onChangeTab);
  }

  void _onUpdateTabHeight(UpdateTabHeightEvent event, Emitter<TabHeightState> emit) {
    List<double> updatedHeights = List.from(state.tabHeights);
    updatedHeights[event.tabIndex] = event.height;
    
    double currentHeight = state.currentHeight;
    if (event.tabIndex == state.currentTabIndex) {
      currentHeight = event.height;
    }
    
    emit(state.copyWith(
      tabHeights: updatedHeights,
      currentHeight: currentHeight,
    ));
  }

  void _onChangeTab(ChangeTabEvent event, Emitter<TabHeightState> emit) {
    emit(state.copyWith(
      currentTabIndex: event.tabIndex,
      currentHeight: state.tabHeights[event.tabIndex],
    ));
  }
}