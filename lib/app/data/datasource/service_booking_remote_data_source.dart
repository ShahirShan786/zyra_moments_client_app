import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/service_booking_reqeuest_model.dart';
import 'package:zyra_momments_app/app/data/models/service_booking_response_model.dart';

import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/app/data/models/vendor_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:http/http.dart' as http;

abstract class ServiceBookingRemoteDataSource {
  Future<Either<Failure, VendorModel>> getServiceDetails(String clientId);
  Future<Either<Failure, List<Booking>>> getAllRemoteBookingDetails();
  Future<Either<Failure, BookingResponseModel>> serviceBookingRequest(
      BookingRequestModel requestData);
  Future<Either<Failure, String>> serviceBookingStatusRequest(
      String bookingId, String status);
}

class ServiceBookingRemoteDataSourceImpl
    implements ServiceBookingRemoteDataSource {
  var client = http.Client();
  @override
  Future<Either<Failure, VendorModel>> getServiceDetails(
      String clientId) async {
    log("Enter getService details function");
    final user = await SecureStorageHelper.loadUser();

    final accessToken = user['access_token'];
    try {
      final response = await client.get(
        Uri.parse(
            "${ApiKey().baseUrl}${ApiKey().clientNpoint}$clientId/details?servicePage=1&workSamplePage=1&limit=2"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        log("${response.statusCode}");
        log(" service  : ${response.body}");
        return Right(VendorModel.fromJson(responseData));
      } else {
        return Left(responseData["message"]);
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getAllRemoteBookingDetails() async {
    final user = await SecureStorageHelper.loadUser();
    final accessToken = user['access_token'];
    try {
      final response = await client.get(
        Uri.parse(
            "${ApiKey().baseUrl}${ApiKey().clientNpoint}${ApiKey().getAllBookingDetails}"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        final bookingsJson = responseData['bookings'] as List;
        final bookings =
            bookingsJson.map((json) => Booking.fromJson(json)).toList();
        return Right(bookings);
      } else {
        return Left(ServerFailure(message: "Failed to fetch booking details."));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BookingResponseModel>> serviceBookingRequest(
      BookingRequestModel requestData) async {
    log("enter to the paymentIntent funciton");
    final user = await SecureStorageHelper.loadUser();
    final accessToken = user['access_token'];
    try {
      final response = await client.post(
        Uri.parse("${ApiKey().baseUrl}${ApiKey().serviceBookingRequest}"),
        body: jsonEncode(requestData.toJson()),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        log("${response.statusCode}");
        log(" service  : ${response.body}");
        return Right(responseData);
      } else {
        return Left(ServerFailure(
            message: responseData['message'] ?? 'Booking failed'));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> serviceBookingStatusRequest(
      String bookingId, String status) async {
    log(" entered booking status function");
    final user = await SecureStorageHelper.loadUser();
    final accessToken = user['access_token'];
    try {
      final response = await client.patch(
        Uri.parse(
            "${ApiKey().baseUrl}/api/v_1/_pvt/_cl/client/booking/status?bookingId=$bookingId&status=$status"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        log("${response.statusCode}");
        log(response.body);
        return Right(responseData["message"]);
      } else {
        return Left(ServerFailure(
            message: responseData["message"] ?? "Fail to update status"));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }
}
