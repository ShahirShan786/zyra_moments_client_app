import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  // Default initial location (you can change this to your preferred location)
  static const LatLng _defaultLocation = LatLng(37.7749, -122.4194); // San Francisco
  // Or use your local coordinates:
  // static const LatLng _defaultLocation = LatLng(10.0261, 76.3125); // Kochi, Kerala
  
  MapBloc() : super(MapLoaded(_defaultLocation)) { // Start with initial location loaded
    
    on<LoadInitialLocationEvent>((event, emit) {
      emit(MapLoaded(_defaultLocation));
    });
    
    on<SearchLoacationEvent>((event, emit) async {
      emit(MapLoading());
      try {
        List<Location> locations = await locationFromAddress(event.location);

        if (locations.isNotEmpty) {
          emit(MapLoaded(LatLng(locations[0].latitude, locations[0].longitude)));
        } else {
          emit(MapError("Location Not Found"));
        }
      } catch (e) {
        emit(MapError("Error: ${e.toString()}"));
      }
    });
  }
}