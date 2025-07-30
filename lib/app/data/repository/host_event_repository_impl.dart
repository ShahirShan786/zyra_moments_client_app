import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/host_event_remote_data_source.dart';
import 'package:zyra_momments_app/app/data/models/attendies_response_model.dart';
import 'package:zyra_momments_app/app/data/models/host_event.dart';
import 'package:zyra_momments_app/app/data/models/host_event_model.dart';
import 'package:zyra_momments_app/app/domain/repository/host_event_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class HostEventRepositoryImpl implements HostEventRepository{
  final HostEventRemoteDataSource hostEventRemoteDataSource = HostEventRemoteDataSourceImpl();
  @override
  Future<Either<Failure, HostEventModel>> getHostEventListFromRemoteDataSourece() async{
    return await hostEventRemoteDataSource.getHostedEventsList();
  }
  
  @override
  Future<Either<Failure, String>> uploadImageToCloudinery(File image) {
    
  return hostEventRemoteDataSource.uploadImage(image);
  }

  @override
  Future<Either<Failure, String>> createEvent(HostEvent eventData) async{
   return await hostEventRemoteDataSource.createEvent(eventData);
  }
  
  @override
  Future<Either<Failure, void>> requestToFundRelease(String eventId, String message) async{
     return await hostEventRemoteDataSource.hostEvetFundRequest(eventId, message);
  }

  @override
  Future<Either<Failure, AttendanceResponse>> getAllAttendiesList(String eventId)async {
   
   return await hostEventRemoteDataSource.getAttediesList(eventId);
  }
  

  

}