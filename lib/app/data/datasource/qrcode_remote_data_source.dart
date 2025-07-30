import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:http/http.dart' as http;

abstract class QrcodeRemoteDataSource {
  Future<Either<Failure, void>> sendQrcodeinfo(String qrIfo);
  
}

class QrcodeRemoteDataSourceImpl implements QrcodeRemoteDataSource {
  @override
  Future<Either<Failure, void>> sendQrcodeinfo(String qrIfo) async {
    var client = http.Client();

    try {
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      final data = {"qrCode": qrIfo};

      final url = "${ApiKey().baseUrl}/api/v_1/_pvt/_qr/client/ticket";

      final response = await client.put(Uri.parse(url),
          headers: {
            'Cookie': 'client_access_token=$accessToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        return Right(null);
      } else {
        return Left(ServerFailure(message: responseData["message"] ?? "Failed to load QR code info"));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }
}
