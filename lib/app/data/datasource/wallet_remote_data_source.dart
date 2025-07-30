import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/wallet_response_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import  'package:http/http.dart'as http;
abstract class WalletRemoteDataSource {
  Future<Either<Failure , WalletResponseModel>> getWalletDetails();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
      final client  = http.Client();
    
 @override
Future<Either<Failure, WalletResponseModel>> getWalletDetails() async {
  final user = await SecureStorageHelper.loadUser();
  final accessToken = user['access_token'];

  try {
    final response = await client.get(
      Uri.parse("${ApiKey().baseUrl}${ApiKey().clientNpoint}${ApiKey().getWallet}"),
      headers: {
        'Cookie': 'client_access_token=$accessToken',
        'Content-Type': 'application/json',
      },
    );

    final responseData = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        if (responseData["success"] == true) {
          final walletResponse = WalletResponseModel.fromJson(responseData);
          return Right(walletResponse);
        } else {
          return Left(ServerFailure(message: responseData["message"] ?? "Failed to fetch wallet data."));
        }
      case 401:
        return Left(ServerFailure(message: "Unauthorized. Please log in again."));

      case 403:
        return Left(ServerFailure(message: "Forbidden. You don't have access to this resource."));

      case 404:
        return Left(ServerFailure(message: "Wallet data not found."));

      case 500:
        return Left(ServerFailure(message: "Server error. Please try again later."));

      default:
        return Left(ServerFailure(
          message: responseData["message"] ?? "Unexpected error: ${response.statusCode}",
        ));
    }
  } catch (e) {
    return Left(ServerFailure(message: "Exception Occurred: ${e.toString()}"));
  }
}

  
}