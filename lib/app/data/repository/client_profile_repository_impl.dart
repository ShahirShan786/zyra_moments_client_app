import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/client_profile_remote_data_source.dart';
import 'package:zyra_momments_app/app/data/models/client_model.dart';
import 'package:zyra_momments_app/app/domain/repository/client_profile_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class ClientProfileRepositoryImpl implements ClientProfileRepository{
  final ClientProfileRemoteDataSource clientProfileRemoteDataSource = ClientProfileRemoteDataSourceImpl();
  @override
  Future<Either<Failure, ClientModel>> getClientProfileDetails()async {
   return await clientProfileRemoteDataSource.getClientProfile();
  }

  @override
  Future<Either<Failure, void>> updateClientProfle(UpdateClientRequest request)async {
   return await clientProfileRemoteDataSource.updateClientProfileRequest(request);
  }

  @override
  Future<String> uploadImageToCloudinery(File imagePath) async{
    return await clientProfileRemoteDataSource.uploadImageToCloudinery(imagePath);
  }
  
}