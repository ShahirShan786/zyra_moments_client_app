import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/attendies_response_model.dart';
import 'package:zyra_momments_app/app/data/models/host_event.dart';
import 'package:zyra_momments_app/app/data/models/host_event_model.dart';
import 'package:zyra_momments_app/app/data/repository/host_event_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/host_event_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class HostEventUsecases {
  final HostEventRepository hostEventRepository = HostEventRepositoryImpl();
  Future<Either<Failure ,HostEventModel>> getAllHostedEvent()async{
     return await hostEventRepository.getHostEventListFromRemoteDataSourece();
  
  }

  Future<Either<Failure , String>> uploadImageToCloudinery(File image)async{
    return await hostEventRepository.uploadImageToCloudinery(image);
  }

  Future<Either<Failure , String>> createEvent(HostEvent eventData)async{
    return await hostEventRepository.createEvent(eventData);
  }

  Future<Either<Failure , void>> requestToFundRelease(String eventId , String message)async{
    return await hostEventRepository.requestToFundRelease(eventId, message);
  }

    Future<Either<Failure , AttendanceResponse>> getAllAttendiesList(String eventId)async{
      return await hostEventRepository.getAllAttendiesList(eventId);
    }
}