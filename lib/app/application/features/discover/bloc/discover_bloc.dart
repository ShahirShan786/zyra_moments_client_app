import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverInitial()) {
    on<StartAnimationEvent>((event, emit) async{
      emit(DiscoverAnimating(animate: false));

      await Future.delayed(const Duration(milliseconds: 300));
      emit(DiscoverAnimating(animate: true));
    });
  }
}
