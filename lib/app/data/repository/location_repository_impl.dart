import 'package:zyra_momments_app/app/domain/entities/place_location.dart';
import 'package:zyra_momments_app/app/domain/repository/location_repository.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationRepositoryImpl implements LocationRepository{
  @override
  Future<PlaceLocation> getCoordinatesFromPlace(String placeName) async{
     final locations = await geo.locationFromAddress(placeName);
     final location = locations.first;

     return PlaceLocation(name: placeName, latitude: location.latitude, longitude: location.longitude);

  }
  
}