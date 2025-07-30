import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/app/data/repository/event_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/evnt_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class EventUsecases {
  final EventRepository eventRepository = EventRepositoryImpl();
   Future<Either<Failure , EventResponse>> getAllEventList()async{
    return eventRepository.getAllEventList();
   }

   Future<Either<Failure , EventResponse>> getAllDicoverListEvent(String searchText)async{
    return await eventRepository.getAllDicoverListEvent(searchText);
   }
}