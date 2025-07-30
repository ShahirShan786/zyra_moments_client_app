import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/client_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class ClientProfileRepository {
  Future<Either<Failure , ClientModel>> getClientProfileDetails();

  Future<Either<Failure , void>> updateClientProfle(UpdateClientRequest request);

  Future<String> uploadImageToCloudinery(File imagePath); 
}