import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/core/error/exeptions.dart';
import 'package:zyra_momments_app/data/models/active_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:zyra_momments_app/domain/entities/login_entity.dart';
// Import your custom exceptions

abstract class LoginRemoteDataSource {
  Future<ActiveUser> login(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  var client = http.Client();

  @override
  Future<ActiveUser> login(String email, String password) async {
    log("Entered the login function..");
    
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "role": "client"
    };
    
    log("Attempting login with email: $email");

    try {
      final response = await client.post(
        Uri.parse("${ApiKey().baseUrl}${ApiKey().nPoint}login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw NetworkException("Connection timeout. Please check your internet connection and try again.");
        },
      );

      final responseData = jsonDecode(response.body);
      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      switch (response.statusCode) {
        case 200:
          if (responseData["success"] == true) {
            final userJson = responseData["user"];
            final accessToken = responseData["accessToken"];
            final refreshToken = responseData["refreshToken"];
            
            if (userJson == null || accessToken == null || refreshToken == null) {
              throw ServerException("Invalid response format from server.");
            }
            
            return ActiveUserModel.fromJson(userJson, accessToken, refreshToken);
          } else {
            throw ServerException(responseData["message"] ?? "Login failed due to server error.");
          }

        case 400:
          throw ValidationException(
            responseData["message"] ?? "Please check your email and password format."
          );

        case 401:
          throw AuthenticationException(
            responseData["message"] ?? "Invalid email or password. Please check your credentials and try again."
          );

        case 403:
          throw AuthenticationException(
            responseData["message"] ?? "Your account has been disabled. Please contact support for assistance."
          );

        case 404:
          throw AuthenticationException(
            responseData["message"] ?? "No account found with this email address. Please sign up first."
          );

        case 422:
          throw ValidationException(
            responseData["message"] ?? "Please provide valid email and password."
          );

        case 429:
          throw NetworkException(
            "Too many login attempts. Please wait a few minutes before trying again."
          );

        case 500:
        case 502:
        case 503:
        case 504:
          throw ServerException(
            "Our servers are experiencing issues. Please try again in a few moments."
          );

        default:
          throw ServerException(
            responseData["message"] ?? "An unexpected error occurred (${response.statusCode}). Please try again."
          );
      }
    } on SocketException {
      throw NetworkException(
        "No internet connection. Please check your network settings and try again."
      );
    } on HttpException {
      throw NetworkException(
        "Unable to connect to our servers. Please try again later."
      );
    } on FormatException {
      throw ServerException(
        "Invalid response from server. Please try again."
      );
    } on NetworkException {
      rethrow; // Re-throw our custom network exceptions
    } on AuthenticationException {
      rethrow; // Re-throw our custom authentication exceptions
    } on ValidationException {
      rethrow; // Re-throw our custom validation exceptions
    } on ServerException {
      rethrow; // Re-throw our custom server exceptions
    } catch (e) {
      log("Unexpected login error: $e");
      throw ServerException(
        "An unexpected error occurred during login. Please try again."
      );
    }
  }
}




