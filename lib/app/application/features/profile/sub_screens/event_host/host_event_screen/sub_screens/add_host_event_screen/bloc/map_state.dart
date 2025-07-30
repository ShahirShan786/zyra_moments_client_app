part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();
  
  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapLoaded extends MapState {
  final LatLng position;
  final bool isSearchResult;

  const MapLoaded(this.position, {this.isSearchResult = false});
  
  @override
  List<Object> get props => [position, isSearchResult];
}

final class MapError extends MapState {
  final String errorMessage;

  const MapError(this.errorMessage);
  
  @override
  List<Object> get props => [errorMessage];
}