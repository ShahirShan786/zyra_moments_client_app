part of 'host_request_bloc.dart';

sealed class HostRequestEvent extends Equatable {
  const HostRequestEvent();

  @override
  List<Object> get props => [];
}


final class HostFundRequest extends HostRequestEvent{
  final String eventId;
  final String message;

 const HostFundRequest({required this.eventId, required this.message});
 @override
  List<Object> get props => [eventId, message];
}

final class AttendiesDetailsRequest extends HostRequestEvent{
  final String eventId;

const  AttendiesDetailsRequest({required this.eventId});
@override
  List<Object> get props => [eventId];
}