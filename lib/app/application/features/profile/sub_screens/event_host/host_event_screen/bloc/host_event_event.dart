part of 'host_event_bloc.dart';

sealed class HostEventEvent extends Equatable {
  const HostEventEvent();

  @override
  List<Object> get props => [];
}

class GetHostEventListRequest extends HostEventEvent{}