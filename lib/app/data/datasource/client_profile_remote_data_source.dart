import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/client_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/api/token_refresh_service.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:http/http.dart'as http;
abstract class ClientProfileRemoteDataSource {
  Future<Either<Failure , ClientModel>> getClientProfile();
  Future<String> uploadImageToCloudinery(File imageFile);
   Future<Either<Failure, void>> updateClientProfileRequest(
      UpdateClientRequest request);
}

class ClientProfileRemoteDataSourceImpl implements ClientProfileRemoteDataSource{
    var client = http.Client();
 @override
Future<Either<Failure, ClientModel>> getClientProfile() async {
  try {
    final userData = await SecureStorageHelper.loadUser();
    String? accessToken = userData['access_token'];

    final response = await client.get(
      Uri.parse("${ApiKey().baseUrl}${ApiKey().clientNpoint}details"),
      headers: {
        'Cookie': 'client_access_token=$accessToken',
        'Content-Type': 'application/json',
      },
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200 && responseData['success'] == true) {
      final data = ClientModel.fromJson(responseData['client']);
      return Right(data);
    }

    // If token is expired (401 Unauthorized), try refresh
    if (response.statusCode == 401) {
      try {
        final newAccessToken = await TokenRefreshService.refreshAccessToken();

        if (newAccessToken == null) {
          return Left(ServerFailure(message: "Unable to refresh token"));
        }

        // Retry the request with new access token
        final retryResponse = await client.get(
          Uri.parse("${ApiKey().baseUrl}${ApiKey().clientNpoint}details"),
          headers: {
            'Cookie': 'client_access_token=$newAccessToken',
            'Content-Type': 'application/json',
          },
        );

        final retryData = jsonDecode(retryResponse.body);

        if (retryResponse.statusCode == 200 &&
            retryData['success'] == true) {
          final data = ClientModel.fromJson(retryData['client']);
          return Right(data);
        } else {
          return Left(ServerFailure(
              message: retryData['message'] ?? "Retry failed"));
        }
      } catch (e) {
        return Left(ServerFailure(message: "Token refresh failed: $e"));
      }
    }

    return Left(ServerFailure(
        message: responseData['message'] ?? "Failed to get client profile"));
  } catch (e) {
    return Left(ServerFailure(message: "Client profile error: $e"));
  }
}

  
  @override
  Future<String> uploadImageToCloudinery(File imageFile) async{
     const String cloudName = 'dwqid6eof';
    const String uploadPreset = 'client_profile';

    final url =
        Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(responseBody);
      return data['secure_url'];
    } else {
      throw Exception("Cloudinary upload failed: $responseBody");
    }
  }
  
  @override
  Future<Either<Failure, void>> updateClientProfileRequest(UpdateClientRequest request) async{
 log('entered the profile updation function..');
    try {
      final userData = await SecureStorageHelper.loadUser();
      final accessToken = userData['access_token'];

      final response = await client.put(
        Uri.parse(
            "${ApiKey().baseUrl}/api/v_1/_pvt/_cl/client/details"),
        body: jsonEncode(request.toJson()),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        log("profile updated successfully");
        log("${response.statusCode}");
        log(response.body);
        return Right(null);
      } else {
        return Left(ServerFailure(
          message: responseData['message'] ?? "Failed to update profile",
        ));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Vendor update error: $e"));
    }
  }
}
 
  
