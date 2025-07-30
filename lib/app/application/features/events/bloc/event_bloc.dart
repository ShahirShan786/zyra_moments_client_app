import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/event_usecases.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventUsecases eventUsecases = EventUsecases();
  EventBloc() : super(EventInitial()) {
    on<GetAllEventRequest>((event, emit)async {
       emit(GetAllEventLoadingState());

       final result = await eventUsecases.getAllEventList();

       result.fold((failure){
        emit(GetAllEVentFailureState(errorMessage: failure.message));
       }, (eventList){
        emit(GetAllEventSuccessState(events: eventList.events));
       });
    });
  
     on<GetAllDiscoverEventList>((event, emit)async {
       emit(GetAllEventLoadingState());

       final result = await eventUsecases.getAllDicoverListEvent(event.searchText);

       result.fold((failure){
        emit(GetAllEVentFailureState(errorMessage: failure.message));
       }, (eventList){
          if(eventList.events.isEmpty){
          emit(EventNotFound());
          }else{
             emit(GetAllEventSuccessState(events: eventList.events));
          }
       });
    });
    
  }
}
