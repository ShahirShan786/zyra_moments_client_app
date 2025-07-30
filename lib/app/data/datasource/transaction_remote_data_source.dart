import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/transaction_response_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:http/http.dart' as http;

abstract class TransactionRemoteDataSource {
  Future<Either<Failure, TransactionResponseModel>> getAllRemoteTransactionDetails();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final client = http.Client();

  @override
  Future<Either<Failure, TransactionResponseModel>> getAllRemoteTransactionDetails() async {
    final user = await SecureStorageHelper.loadUser();
    final accessToken = user['access_token'];
    try {
      final response = await client.get(
        Uri.parse("${ApiKey().baseUrl}${ApiKey().clientNpoint}${ApiKey().getAllTransaction}"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          if (responseData["success"] == true) {
            final transactionResponse = TransactionResponseModel.fromJson(responseData);
            return Right(transactionResponse);
          } else {
            return Left(ServerFailure(
                message: responseData["message"] ?? "Failed to fetch transaction data"));
          }
        case 400:
          return Left(ServerFailure(message: "Bad Request: ${responseData["message"] ?? "Invalid request"}"));
        case 401:
          return Left(ServerFailure(message: "Unauthorized: Please login again."));
        case 403:
          return Left(ServerFailure(message: "Forbidden: You don't have permission to access this resource."));
        case 404:
          return Left(ServerFailure(message: "Not Found: The requested resource was not found."));
        case 500:
          return Left(ServerFailure(message: "Internal Server Error: Please try again later."));
        default:
          return Left(ServerFailure(
              message: "Unexpected error occurred: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }
}
