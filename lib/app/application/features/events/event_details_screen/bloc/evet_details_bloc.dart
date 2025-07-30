import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zyra_momments_app/app/domain/usecases/get_coordinates_from_place_usecase.dart';
// if you made a custom entity

part 'evet_details_event.dart';
part 'evet_details_state.dart';

class EvetDetailsBloc extends Bloc<EvetDetailsEvent, EvetDetailsState> {
  final Getcoordinatesfromplaceusecase getcoordinatesfromplaceusecase;

  EvetDetailsBloc(this.getcoordinatesfromplaceusecase) : super(EvetDetailsInitial()) {
    on<LoadEventLocationEvent>((event, emit) async {
      emit(EvetDetailsLoading()); // optional loading state

      try {
        final location = await getcoordinatesfromplaceusecase.getCoordinatesFromPlace(event.placeName);

        final target = LatLng(location.latitude, location.longitude);

        final marker = Marker(
          markerId: const MarkerId("event_location"),
          position: target,
          infoWindow: InfoWindow(title: event.placeName),
        );

        emit(EvetDetailsLoaded(
          targetPosition: target,
          markers: {marker},
        ));
      } catch (e) {
        emit(EvetDetailsError("Failed to load location: ${e.toString()}"));
      }
    });
  }
}
