part of 'evet_details_bloc.dart';

sealed class EvetDetailsState extends Equatable {
  const EvetDetailsState();

  @override
  List<Object?> get props => [];
}

final class EvetDetailsInitial extends EvetDetailsState {}

final class EvetDetailsLoading extends EvetDetailsState {}

final class EvetDetailsLoaded extends EvetDetailsState {
  final LatLng targetPosition;
  final Set<Marker> markers;

  const EvetDetailsLoaded({
    required this.targetPosition,
    required this.markers,
  });

  @override
  List<Object> get props => [targetPosition, markers];
}

final class EvetDetailsError extends EvetDetailsState {
  final String message;

  const EvetDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
