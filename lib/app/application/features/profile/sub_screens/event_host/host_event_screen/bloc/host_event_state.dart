part of 'host_event_bloc.dart';

sealed class HostEventState extends Equatable {
  const HostEventState();
  
  @override
  List<Object> get props => [];
}

final class HostEventInitial extends HostEventState {}

final class GetHostEventListLoadingState extends HostEventState{}

final class GetHostEventListSuccessState extends HostEventState{
  final List<Event> hostEventList;

 const GetHostEventListSuccessState({required this.hostEventList});

  @override
  List<Object> get props => [hostEventList];
}

final class GetHostEventFailureState extends HostEventState{
  final String errorMessage;

 const GetHostEventFailureState({required this.errorMessage});

   @override
  List<Object> get props => [errorMessage];
}