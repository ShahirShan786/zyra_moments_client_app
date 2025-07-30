import 'package:zyra_momments_app/app/domain/entities/place_location.dart';

abstract class LocationRepository {
  Future<PlaceLocation> getCoordinatesFromPlace(String placeName);
}