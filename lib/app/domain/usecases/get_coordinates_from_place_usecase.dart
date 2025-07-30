import 'package:zyra_momments_app/app/data/repository/location_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/entities/place_location.dart';
import 'package:zyra_momments_app/app/domain/repository/location_repository.dart';

class Getcoordinatesfromplaceusecase {
  final LocationRepository locationRepository = LocationRepositoryImpl();
   Future<PlaceLocation> getCoordinatesFromPlace(String placeName)async{
   return locationRepository.getCoordinatesFromPlace(placeName);
   }
}