import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/attendies_response_model.dart';
import 'package:zyra_momments_app/app/data/models/host_event.dart';
import 'package:zyra_momments_app/app/data/models/host_event_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class HostEventRepository {
  Future<Either<Failure , HostEventModel>> getHostEventListFromRemoteDataSourece();
  Future<Either<Failure , String>> uploadImageToCloudinery(File image);
  Future<Either<Failure , String>> createEvent(HostEvent eventData);
  Future<Either<Failure ,void>> requestToFundRelease(String eventId , String message);
  Future<Either<Failure , AttendanceResponse>> getAllAttendiesList(String eventId);

}