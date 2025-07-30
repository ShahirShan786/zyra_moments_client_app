part of 'host_request_bloc.dart';

sealed class HostRequestState extends Equatable {
  const HostRequestState();
  
  @override
  List<Object> get props => [];
}

final class HostRequestInitial extends HostRequestState {}

final class HostRequestLoading extends HostRequestState{}

final class HostRequestSuccess extends HostRequestState{}

final class HostRequestFailure extends HostRequestState{
  final String errorMessage;

const  HostRequestFailure({required this.errorMessage});
 @override
  List<Object> get props => [errorMessage];
}


final class AttendiesDataLoading extends HostRequestState{}

final class AttendiesDataLoaded extends HostRequestState{
  final EventData attendiesData;

const  AttendiesDataLoaded({required this.attendiesData});
}

final class AttendiesDataFailure extends HostRequestState{
  final String errorMessage;

 const AttendiesDataFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}