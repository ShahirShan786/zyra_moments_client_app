part of 'event_bloc.dart';

sealed class EventState extends Equatable {
  const EventState();
  
  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

final class GetAllEventLoadingState extends EventState{}

final class GetAllEventSuccessState extends EventState{
  final List<Event> events;

const GetAllEventSuccessState({required this.events});

  @override
  List<Object> get props => [events];
}

final class GetAllEVentFailureState extends EventState{
  final String errorMessage;

 const GetAllEVentFailureState({required this.errorMessage});

   @override
  List<Object> get props => [errorMessage];
}

final class EventNotFound extends EventState{}