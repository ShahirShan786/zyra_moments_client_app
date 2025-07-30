import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/attendies_response_model.dart';
import 'package:zyra_momments_app/app/data/models/host_event.dart';
import 'package:zyra_momments_app/app/data/models/host_event_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:http/http.dart' as http;

abstract class HostEventRemoteDataSource {
  Future<Either<Failure, HostEventModel>> getHostedEventsList();
  Future<Either<Failure, String>> uploadImage(File image);
  Future<Either<Failure, String>> createEvent(HostEvent eventData);
  Future<Either<Failure, void>> hostEvetFundRequest(
      String eventId, String message);
  Future<Either<Failure, AttendanceResponse>> getAttediesList(String eventId);
}

class HostEventRemoteDataSourceImpl implements HostEventRemoteDataSource {
  var client = http.Client();
  @override
  Future<Either<Failure, HostEventModel>> getHostedEventsList() async {
    final user = await SecureStorageHelper.loadUser();
    final accessToken = user['access_token'];
    try {
      var url =
          "${ApiKey().baseUrl}/api/v_1/_pvt/_host/client/hosted-event?page=1&limit=5";

      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        final hostEventModel = HostEventModel.fromJson(responseData);
        return Right(hostEventModel);
      } else if (response.statusCode == 401) {
        return Left(ServerFailure(
            message: "Unauthorized access. Please log in again."));
      } else if (response.statusCode == 403) {
        return Left(ServerFailure(
            message: "Access forbidden. You do not have permission."));
      } else if (response.statusCode == 404) {
        return Left(ServerFailure(message: "Hosted Event list not found."));
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
  Future<Either<Failure, String>> uploadImage(File image) async {
    final String cloudName = "dwqid6eof";
    final String uploadPreset = "host_event_image";
    try {
      final uri =
          Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
      final request = http.MultipartRequest('POST', uri);

      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = jsonDecode(respStr);
        return Right(data['secure_url']); // success
      } else {
        return Left(ServerFailure(
            message:
                ('Image upload failed with status code: ${response.statusCode}')));
      }
    } catch (e) {
      return left(ServerFailure(message: 'Exception during upload: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> createEvent(HostEvent eventData) async {
    log("Entered event creation function");
    try {
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      var url = "${ApiKey().baseUrl}/api/v_1/_pvt/_host/client/host-event";

      final response = await client.post(Uri.parse(url),
          headers: {
            'Cookie': 'client_access_token=$accessToken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(eventData.toJson()));

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        log("${response.statusCode}");
        log(response.body);
        return Right(responseData['message']);
      } else {
        return Left(ServerFailure(
            message: responseData["message"] ?? "Failed to create event"));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception occurred: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> hostEvetFundRequest(
      String eventId, String message) async {
    final user = await SecureStorageHelper.loadUser();
    final accessToken = user['access_token'];

    final Map<String, dynamic> data = {"eventId": eventId, "message": message};

    try {
      final url =
          "${ApiKey().baseUrl}/api/v_1/_pvt/_cl/client/fund-release";

      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode <= 300 &&
          responseData['success'] == true) {
        return Right(null);
      } else {
        return Left(
            responseData["message"] ?? "Failed to Request Fund Release");
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception occurred: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, AttendanceResponse>> getAttediesList(
      String eventId) async {
    final user = await SecureStorageHelper.loadUser();
    final accessToken = user['access_token'];
    try {
      final url =
          "${ApiKey().baseUrl}/api/v_1/_pvt/_host/client/events/$eventId/attendance";
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        final attendiesData = AttendanceResponse.fromJson(responseData);
        return Right(attendiesData);
      } else {
        return Left(ServerFailure(
            message: responseData['message']?.toString() ??
                "Failed to load Attendies Data"));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception occurred: ${e.toString()}"));
    }
  }
}
