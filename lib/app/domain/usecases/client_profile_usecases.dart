import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/client_model.dart';
import 'package:zyra_momments_app/app/data/repository/client_profile_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/client_profile_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class ClientProfileUsecases {
  final ClientProfileRepository clientProfileRepository = ClientProfileRepositoryImpl();
  Future<Either<Failure , ClientModel>> getClientProfileDetails()async{
    return await clientProfileRepository.getClientProfileDetails();
  }

  Future<Either<Failure , void>> updateClientProfileRequest(UpdateClientRequest request)async{
    return await clientProfileRepository.updateClientProfle(request);
  }

    Future<String> uploadImageToCloudinery(File imagePath)async{
     final fileSizeInBytes = await imagePath.length();
    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    
    // Limit file size to 5MB
    if (fileSizeInMB > 5) {
      throw Exception('Image size exceeds 5MB limit');
    }
    
    try {
      // The actual upload implementation
      return await clientProfileRepository.uploadImageToCloudinery(imagePath);
    } catch (e) {
      // Properly handle and propagate errors
      throw Exception('Failed to upload image: $e');
    }
  }
} 