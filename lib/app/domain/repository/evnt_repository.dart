import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class EventRepository {
  Future<Either<Failure , EventResponse>> getAllEventList();
  Future<Either<Failure , EventResponse>> getAllDicoverListEvent(String searchText);
}