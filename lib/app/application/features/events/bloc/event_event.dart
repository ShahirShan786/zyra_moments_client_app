part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}


class GetAllEventRequest extends EventEvent{}

class GetAllDiscoverEventList extends EventEvent{
   final String searchText;

const  GetAllDiscoverEventList({required this.searchText});

  @override
  List<Object> get props => [searchText];
}

