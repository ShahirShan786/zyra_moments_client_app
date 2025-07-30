import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/event_remote_data_source.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/app/domain/repository/evnt_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class EventRepositoryImpl implements EventRepository{
   EventRemoteDataSource eventRemoteDataSource = EventRemoteDataSourceImpl();
  @override
  Future<Either<Failure, EventResponse>> getAllEventList()async {
  return await eventRemoteDataSource.getEventListReqeust();
  }
  
  @override
  Future<Either<Failure, EventResponse>> getAllDicoverListEvent(String searchText)async {
   return await eventRemoteDataSource.getAllDiscoverEventList(searchText);
  }
}