import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';


part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationInitial()) {
    on<NavigationTabChanged>((event, emit) {
      emit(NavigationStateSelected(event.tab));
    });
  }
}
