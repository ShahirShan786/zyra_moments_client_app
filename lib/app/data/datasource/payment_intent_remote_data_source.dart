import "dart:async";
import "dart:convert";
import "dart:developer";
import "package:dartz/dartz.dart";
import "package:http/http.dart" as http;
import "package:zyra_momments_app/app/data/models/ticket_response.dart";
import "package:zyra_momments_app/app/data/models/vendor_booking_model.dart";
import "package:zyra_momments_app/application/core/api/api_keys.dart";
import "package:zyra_momments_app/application/core/user_info.dart";
import "package:zyra_momments_app/core/error/failure.dart";

abstract class PaymentIntentRemoteDataSource {
  // for Master of ceremonies
  Future<Either<Failure, String>> createPaymentIntentForDiscoverFromRemote(
      String amount, String purpose);
  Future<Either<Failure, void>> confirmPayment(String clientSecret);

  // for Evnet booking
  Future<Either<Failure, String>> createPaymentIntetForEventBokingFromRemote(
      String amount, String purpose);
  Future<Either<Failure, void>> confirmPaymentForEventBooking(
      String clientSecret);
  Future<Either<Failure, TicketResponse>> getTicketDetails(String eventID);

  // for vendor service booking
  Future<Either<Failure, String>>
      createPaymentIntentForServiceBookingFromRemote(
          VendorBookingModel vendorBookingData);
  Future<Either<Failure, void>> confirmPaymentForServiceBooking(
      String clientSecret);
}

class PaymentIntentRemoteDataSourceImpl
    implements PaymentIntentRemoteDataSource {
  final client = http.Client();

  @override
  Future<Either<Failure, String>> createPaymentIntentForDiscoverFromRemote(
      String amount, String purpose) async {
    try {
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      log("Creating payment intent for amount: $amount, purpose: $purpose");
      log("Using access token: ${accessToken?.substring(0, 10)}...");

      // Convert amount to paise if needed (multiply by 100)
      final amountInPaise = (double.parse(amount) * 100).toInt().toString();

      final data = {
        "amount":
            amountInPaise, // Make sure amount is in smallest currency unit
        "purpose": purpose,
        "currency": "inr", // Explicitly set currency
      };

      log("Request data: ${jsonEncode(data)}");

      final response = await client
          .post(
            Uri.parse(
                "${ApiKey().baseUrl}/api/v_1/_pvt/_pmt/client/create-payment-intent"),
            headers: {
              'Cookie': 'client_access_token=$accessToken',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 30)); // Add timeout

      log("Response status: ${response.statusCode}");
      log("Response headers: ${response.headers}");
      log("Response body: ${response.body}");

      if (response.statusCode != 200) {
        log("HTTP Error: ${response.statusCode} - ${response.body}");
        return Left(
            ServerFailure(message: "Server error: ${response.statusCode}"));
      }

      final responseData = jsonDecode(response.body);

      if (responseData["success"] == true) {
        final clientSecret = responseData["clientSecret"];
        if (clientSecret != null && clientSecret.isNotEmpty) {
          // Validate client secret format
          if (clientSecret.startsWith('pi_') &&
              clientSecret.contains('_secret_')) {
            log("Payment intent created successfully: $clientSecret");
            return Right(clientSecret);
          } else {
            log("Invalid client secret format received: $clientSecret");
            return Left(ServerFailure(message: "Invalid client secret format"));
          }
        } else {
          log("Empty client secret received");
          return Left(ServerFailure(message: "Empty client secret received"));
        }
      } else {
        final errorMessage =
            responseData["message"] ?? "Failed to create payment intent";
        log("API returned success=false: $errorMessage");
        return Left(ServerFailure(message: errorMessage));
      }
    } on TimeoutException {
      log("Request timeout");
      return Left(ServerFailure(message: "Request timeout. Please try again."));
    } catch (e) {
      log("Exception in createPaymentIntentForDiscoverFromRemote: $e");
      log("Exception type: ${e.runtimeType}");
      return Left(ServerFailure(message: "Network error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPayment(String clientSecret) async {
    try {
      // Extract payment intent ID from client secret
      final intentId = clientSecret.split("_secret")[0];
      log("Confirming payment with intent ID: $intentId");

      final data = {'paymentIntentId': intentId};
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      final response = await client.post(
        Uri.parse(
            "${ApiKey().baseUrl}/api/v_1/_pvt/_pmt/client/confirm-payment"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);
      log("Confirm payment response: ${response.body}");

      if (response.statusCode == 200 && responseData["success"] == true) {
        log("Payment confirmation successful");
        return Right(null);
      } else {
        return Left(ServerFailure(
            message: responseData['message'] ?? "Failed to confirm payment"));
      }
    } catch (e) {
      log("Exception in confirmPayment: $e");
      return Left(ServerFailure(message: "Network error: ${e.toString()}"));
    }
  }

  // For Event booking

  @override
  Future<Either<Failure, String>> createPaymentIntetForEventBokingFromRemote(
      String amount, String purpose) async {
    try {
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      log("Creating payment intent for amount: $amount, purpose: $purpose");
      log("Using access token: ${accessToken?.substring(0, 10)}...");

      // Convert amount to paise if needed (multiply by 100)
      final amountInPaise = (double.parse(amount) * 100).toInt().toString();

      final data = {
        "amount":
            amountInPaise, // Make sure amount is in smallest currency unit
        "purpose": purpose,
        "currency": "inr", // Explicitly set currency
      };

      log("Request data: ${jsonEncode(data)}");

      final response = await client
          .post(
            Uri.parse(
                "${ApiKey().baseUrl}/api/v_1/_pvt/_pmt/client/create-payment-intent"),
            headers: {
              'Cookie': 'client_access_token=$accessToken',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 30)); // Add timeout

      log("Response status: ${response.statusCode}");
      log("Response headers: ${response.headers}");
      log("Response body: ${response.body}");

      if (response.statusCode != 200) {
        log("HTTP Error: ${response.statusCode} - ${response.body}");
        return Left(
            ServerFailure(message: "Server error: ${response.statusCode}"));
      }

      final responseData = jsonDecode(response.body);

      if (responseData["success"] == true) {
        final clientSecret = responseData["clientSecret"];
        if (clientSecret != null && clientSecret.isNotEmpty) {
          // Validate client secret format
          if (clientSecret.startsWith('pi_') &&
              clientSecret.contains('_secret_')) {
            log("Payment intent created successfully: $clientSecret");
            return Right(clientSecret);
          } else {
            log("Invalid client secret format received: $clientSecret");
            return Left(ServerFailure(message: "Invalid client secret format"));
          }
        } else {
          log("Empty client secret received");
          return Left(ServerFailure(message: "Empty client secret received"));
        }
      } else {
        final errorMessage =
            responseData["message"] ?? "Failed to create payment intent";
        log("API returned success=false: $errorMessage");
        return Left(ServerFailure(message: errorMessage));
      }
    } on TimeoutException {
      log("Request timeout");
      return Left(ServerFailure(message: "Request timeout. Please try again."));
    } catch (e) {
      log("Exception in createPaymentIntentForDiscoverFromRemote: $e");
      log("Exception type: ${e.runtimeType}");
      return Left(ServerFailure(message: "Network error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPaymentForEventBooking(
      String clientSecret) async {
    try {
      // Extract payment intent ID from client secret
      final intentId = clientSecret.split("_secret")[0];
      log("Confirming payment with intent ID: $intentId");

      final data = {'paymentIntentId': intentId};
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      final response = await client.post(
        Uri.parse(
            "${ApiKey().baseUrl}/api/v_1/_pvt/_pmt/client/confirm-payment"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);
      log("Confirm payment response: ${response.body}");

      if (response.statusCode == 200 && responseData["success"] == true) {
        log("Payment confirmation successful");
        return Right(null);
      } else {
        return Left(ServerFailure(
            message: responseData['message'] ?? "Failed to confirm payment"));
      }
    } catch (e) {
      log("Exception in confirmPayment: $e");
      return Left(ServerFailure(message: "Network error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, TicketResponse>> getTicketDetails(
      String eventId) async {
    try {
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];
      final data = {"eventId": eventId};

      final url =
          "${ApiKey().baseUrl}/api/v_1/_pvt/_qr/client/new-ticket";
      final response = await client.post(
        Uri.parse(url),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      // Check for successful status codes (200, 201, etc.)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Check if response has the expected structure
        if (responseData.containsKey('ticket') &&
            responseData.containsKey('qrCodeImage')) {
          final newTicketData = TicketResponse.fromJson(responseData);
          return Right(newTicketData);
        } else {
          return Left(ServerFailure(message: "Invalid response structure"));
        }
      } else {
        // Handle error responses
        final errorMessage =
            responseData["message"] ?? "Failed to fetch New Ticket Details.";
        return Left(ServerFailure(message: errorMessage));
      }
    } catch (e) {
      log("Exception in getTicketDetails: $e");
      return Left(ServerFailure(message: "Network error: ${e.toString()}"));
    }
  }

// for vendor service booking

  @override
  Future<Either<Failure, String>>
      createPaymentIntentForServiceBookingFromRemote(
          VendorBookingModel vendorBookingData) async {
    try {
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      log("Creating payment intent for amount: ${vendorBookingData.amount}");
      log("Using access token: ${accessToken?.substring(0, 10)}...");

      // Convert amount to paise (multiply by 100)
      final amountInPaise = (vendorBookingData.amount * 100).toInt();

      // ✅ CORRECTED PAYLOAD STRUCTURE
      final data = {
        "amount": amountInPaise, // Amount in paise
        "purpose": vendorBookingData.purpose, // "vendor-booking"
        "currency": "inr", // Currency
        "bookingData": {
          "bookingDate": vendorBookingData.bookingData.bookingDate,
          "serviceId": vendorBookingData.bookingData.serviceId,
          "timeSlot": {
            "startTime": vendorBookingData.bookingData.timeSlot.startTime,
            "endTime": vendorBookingData.bookingData.timeSlot.endTime,
          },
          // ❌ REMOVED: totalPrice and vendorId from bookingData
          "totalPrice": vendorBookingData.totalPrice, // At root level
          "vendorId": vendorBookingData.vendorId, // At root level
        },
        "createrType": vendorBookingData.createrType, // "Client"
        "receiverType": vendorBookingData.receiverType // "Vendor"
      };

      // Debug log the corrected payload
      log("=== CORRECTED REQUEST PAYLOAD ===");
      log(jsonEncode(data));
      log("===============================");

      final response = await client
          .post(
            Uri.parse(
                "${ApiKey().baseUrl}/api/v_1/_pvt/_pmt/client/create-payment-intent"),
            headers: {
              'Cookie': 'client_access_token=$accessToken',
              'Content-Type': 'application/json',
              // 'Accept': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 30));

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      if (response.statusCode != 200) {
        log("HTTP Error: ${response.statusCode} - ${response.body}");
        return Left(
            ServerFailure(message: "Server error: ${response.statusCode}"));
      }

      final responseData = jsonDecode(response.body);

      if (responseData["success"] == true) {
        log("=== DETAILED API RESPONSE DEBUG ===");
        log("Status Code: ${response.statusCode}");
        log("Response Headers: ${response.headers}");
        log("Raw Response Body: ${response.body}");

        try {
          final responseData = jsonDecode(response.body);
          log("Parsed Response Data: $responseData");

          // Check specific fields
          log("Success field: ${responseData['success']}");
          log("Success field type: ${responseData['success'].runtimeType}");
          log("ClientSecret field: ${responseData['clientSecret']}");
          log("Message field: ${responseData['message']}");
          log("Error field: ${responseData['error']}");

          // Check all keys in response
          log("All response keys: ${responseData.keys.toList()}");
        } catch (e) {
          log("Failed to parse JSON response: $e");
          log("Raw response: ${response.body}");
        }
        log("=================================");

        final clientSecret = responseData["clientSecret"];
        if (clientSecret != null && clientSecret.isNotEmpty) {
          // Validate client secret format
          if (clientSecret.startsWith('pi_') &&
              clientSecret.contains('_secret_')) {
            log("Payment intent created successfully: $clientSecret");
            return Right(clientSecret);
          } else {
            log("Invalid client secret format received: $clientSecret");
            return Left(ServerFailure(message: "Invalid client secret format"));
          }
        } else {
          log("Empty client secret received");
          return Left(ServerFailure(message: "Empty client secret received"));
        }
      } else {
        final errorMessage =
            responseData["message"] ?? "Failed to create payment intent";
        log("API returned success=false: $errorMessage");
        return Left(ServerFailure(message: errorMessage));
      }
    } on TimeoutException {
      log("Request timeout");
      return Left(ServerFailure(message: "Request timeout. Please try again."));
    } catch (e) {
      log("Exception in createPaymentIntentForServiceBookingFromRemote: $e");
      log("Exception type: ${e.runtimeType}");
      return Left(ServerFailure(message: "Network error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPaymentForServiceBooking(
      String clientSecret) async {
    try {
      // Extract payment intent ID from client secret
      final intentId = clientSecret.split("_secret")[0];
      log("Confirming payment with intent ID: $intentId");

      final data = {'paymentIntentId': intentId};
      final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];

      final response = await client.post(
        Uri.parse(
            "${ApiKey().baseUrl}/api/v_1/_pvt/_pmt/client/confirm-payment"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);
      log("Confirm payment response: ${response.body}");

      if (response.statusCode == 200 && responseData["success"] == true) {
        log("Payment confirmation successful");
        return Right(null);
      } else {
        return Left(ServerFailure(
            message: responseData['message'] ?? "Failed to confirm payment"));
      }
    } catch (e) {
      log("Exception in confirmPayment: $e");
      return Left(ServerFailure(message: "Network error: ${e.toString()}"));
    }
  }

  // For ticket
}
