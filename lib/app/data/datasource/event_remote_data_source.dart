import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class EventRemoteDataSource {
  Future<Either<Failure, EventResponse>> getEventListReqeust();
  Future<Either<Failure, EventResponse>> getAllDiscoverEventList(String searchText);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final client = http.Client();

  @override
  Future<Either<Failure, EventResponse>> getEventListReqeust() async {
    try {
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      final response = await client.get(
        Uri.parse("${ApiKey().baseUrl}${ApiKey().upcomings}"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        final eventResponse = EventResponse.fromJson(responseData);
        return Right(eventResponse);
      } else if (response.statusCode == 401) {
        return Left(ServerFailure(
            message: "Unauthorized access. Please log in again."));
      } else if (response.statusCode == 403) {
        return Left(ServerFailure(
            message: "Access forbidden. You do not have permission."));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure(message: "Event list not found."));
      } else if (response.statusCode >= 500) {
        return Left(
            ServerFailure(message: "Server error. Please try again later."));
      } else {
        return Left(ServerFailure(
            message: responseData["message"] ?? "Unknown error occurred."));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception occurred: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, EventResponse>> getAllDiscoverEventList(String searchText ) async {
    try {
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      final response = await client.get(
        Uri.parse(
            "${ApiKey().baseUrl}/api/v_1/_pvt/_host/client/discover-events?page=1&limit=100&search=$searchText&category=&sortField=date&sortOrder=desc&nearby=false&maxDistance=10000"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        final eventResponse = EventResponse.fromJson(responseData);
        return Right(eventResponse);
      } else if (response.statusCode == 401) {
        return Left(ServerFailure(
            message: "Unauthorized access. Please log in again."));
      } else if (response.statusCode == 403) {
        return Left(ServerFailure(
            message: "Access forbidden. You do not have permission."));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure(message: "Event list not found."));
      } else if (response.statusCode >= 500) {
        return Left(
            ServerFailure(message: "Server error. Please try again later."));
      } else {
        return Left(ServerFailure(
            message: responseData["message"] ?? "Unknown error occurred."));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception occurred: ${e.toString()}"));
    }
  }
}
