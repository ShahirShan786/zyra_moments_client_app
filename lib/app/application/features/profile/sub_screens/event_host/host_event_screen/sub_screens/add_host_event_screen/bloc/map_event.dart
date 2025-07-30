part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialLocationEvent extends MapEvent {
  const LoadInitialLocationEvent();
}

class SearchLoacationEvent extends MapEvent{
  final String location;

 const SearchLoacationEvent({required this.location});
   @override
  List<Object> get props => [location];
}