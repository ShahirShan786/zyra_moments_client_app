
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/models/active_user_model.dart';
import 'package:zyra_momments_app/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:zyra_momments_app/domain/entities/login_entity.dart';

abstract class SigninRemoteDataSource {
  Future<String> registerUser(UserModel user);
  Future<Either<Failure , ActiveUser>> registerWithGoogle(String clientId , String accesTocken );

}

class SigninRemoteDataSourceImpl implements SigninRemoteDataSource {
  final client = http.Client();
  @override
  Future<String> registerUser(UserModel user) async {
    var client = http.Client();
    Map<String, dynamic> data = {
      'firstName': user.firstName,
      'lastName': user.lastName,
      'phoneNumber': user.phone,
      'email': user.email,
      'password': user.password,
      'role': "client",
    };
    log("Entered the function..");

    try {
      final response = await client.post(
        Uri.parse(
            "${ApiKey().baseUrl}${ApiKey().nPoint}register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
       
      log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      final responseData = jsonDecode(response.body);
      log("Parsed success value: ${responseData["success"]}");
      if (response.statusCode == 201) {
        return "success";
      } else if(response.statusCode == 409){
        return "email_exists";
      } else{
        return "registration_failed";
      }
     
    } catch (e) {
      log("$e");
      return "registration_failed";
    }
  }


  
  @override
Future<Either<Failure, ActiveUser>> registerWithGoogle(String clientId, String accessToken) async {
  log("Entered the registerWithGoogle function...");

  final client = http.Client();
  Map<String, dynamic> data = {
    'client_id': clientId,
    'credential': accessToken,
    'role': 'client',
  };

  try {
    final response = await client.post(
      Uri.parse("${ApiKey().baseUrl}${ApiKey().nPoint}google-auth"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    log("Response Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");

    final responseData = jsonDecode(response.body);
    log("Parsed success value: ${responseData["success"]}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      log("response body === > :${response.body}");
      if (responseData["success"] == true) {
        final userJson = responseData["user"];
        final accessToken = responseData["accessToken"];
        final refreshToken = responseData["refreshToken"];

        if (userJson == null || accessToken == null || refreshToken == null) {
          return Left(ServerFailure(message: "Invalid response format from server."));
        }

        final user = ActiveUserModel.fromJson(userJson, accessToken, refreshToken);
        return Right(user);
      } else {
        return Left(ServerFailure(message: responseData["message"] ?? "Unknown error from server."));
      }
    } else {
      return Left(ServerFailure(message: "HTTP error: ${response.statusCode}"));
    }
  } catch (e) {
    log("Google register error: $e");
    return Left(ServerFailure(message: "Registration failed: ${e.toString()}"));
  } finally {
    client.close();
  }
}

}