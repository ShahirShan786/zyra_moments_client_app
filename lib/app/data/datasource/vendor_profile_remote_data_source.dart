import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:http/http.dart' as http;
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';
import 'package:zyra_momments_app/data/repository/api_repository.dart';

abstract class VendorProfileRemoteDataSource {
  Future<Either<Failure, VendorProfileModel>> getVendorProfileDetails(
      String categoryId);
  Future<Either<Failure, List<Vendor>>> getBestVendors();
}

class VendorProfileRemoteDataSourceImpl
    implements VendorProfileRemoteDataSource {
  final client = http.Client();
  @override
  Future<Either<Failure, VendorProfileModel>> getVendorProfileDetails(
      String categoryId) async {
    ApiRepository apiRepository = ApiRepository();
    // final user = await SecureStorageHelper.loadUser();
    // final accessToken = user["access_token"];
    try {
      final response = await apiRepository.performRequestWithRefresh(
        (accessToken) {
          return client.get(
            Uri.parse(
                "${ApiKey().baseUrl}${ApiKey().clientNpoint}$categoryId/details"),
            headers: {
              'Cookie': 'client_access_token=$accessToken',
              'Content-Type': 'application/json',
            },
          );
        },
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['success'] == true) {
        final vendorData = VendorProfileModel.fromJson(responseData);

        return Right(vendorData);
      } else {
        return Left(ServerFailure(message: responseData['message']));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<Vendor>>> getBestVendors() async {
    log("Entere the getBestvendor Fucntions");
    try {
      final user = await SecureStorageHelper.loadUser();

      final accessToken = user['access_token'];
      final response = await client.get(
        Uri.parse(
            "${ApiKey().baseUrl}${ApiKey().clientNpoint}${ApiKey().getBestVendors}"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        log("${response.statusCode}");
        log(" Given body of best venors : ${response.body}");
        final vendorResponse = VendorResponse.fromJson(responseData);
        return Right(vendorResponse.vendors);
      } else {
        return Left(ServerFailure(message: responseData['message']));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }
}
