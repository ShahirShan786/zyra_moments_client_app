import 'dart:convert';
import 'dart:developer';


import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/purchased_ticket_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:http/http.dart'as http;
abstract class TicketResponseDataSource {
  Future<Either<Failure , PurchasedTicketModel>> getAllPurchasedTicketResponseFromDataSource();
  Future<Either<Failure , void>> cancelRequestEventFromRemoteDataSource(String eventID);
}

class TicketResponseDataSourceImpl implements TicketResponseDataSource{
  final client = http.Client();
  @override
  Future<Either<Failure, PurchasedTicketModel>> getAllPurchasedTicketResponseFromDataSource()async {
    
    final user = await SecureStorageHelper.loadUser();
      final accessToken = user['access_token'];
      try{
        final url = "${ApiKey().baseUrl}/api/v_1/_pvt/_host/client/purchased-tickets?page=1&limit=5";

        final response = await client.get(Uri.parse(url),
          headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
        );

        final responseData = jsonDecode(response.body);

        switch (response.statusCode) {
        case 200:
          if (responseData["success"] == true) {
            final purchasedTicketData = PurchasedTicketModel.fromJson(responseData);
            return Right(purchasedTicketData);
          } else {
            return Left(ServerFailure(
                message: responseData["message"] ?? "Failed to fetch Purchased Ticket data"));
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
      }catch(e){
         return Left(ServerFailure(message: "Exception Occurred: ${e.toString()}"));
      }
  }
@override
Future<Either<Failure, void>> cancelRequestEventFromRemoteDataSource(String ticketObjectId) async {
  final user = await SecureStorageHelper.loadUser();
  final accessToken = user['access_token'];
  
  try {
    // Use the MongoDB ObjectId in the URL - using the original query parameter format
    final url = "${ApiKey().baseUrl}/api/v_1/_pvt/_host/client/ticket/cancel?ticketId=$ticketObjectId";
    
    log("=== CANCEL TICKET DEBUG ===");
    log("Ticket ObjectId: $ticketObjectId");
    log("URL: $url");
    
    final response = await client.patch( // Using PATCH as in original code
      Uri.parse(url),
      headers: {
        'Cookie': 'client_access_token=$accessToken',
        'Content-Type': 'application/json',
      },
    );

    log("Response Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");

    // Handle success responses
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        log("✅ Success: Empty response body");
        return const Right(null);
      }
      
      try {
        final responseData = jsonDecode(response.body);
        
        if (responseData.containsKey("success")) {
          if (responseData["success"] == true) {
            log("✅ Success: API returned success=true");
            return const Right(null);
          } else {
            log("❌ API returned success=false: ${responseData["message"]}");
            return Left(ServerFailure(
                message: responseData["message"] ?? "Failed to Cancel Event"));
          }
        } else {
          log("✅ Success: No success field, but successful status code");
          return const Right(null);
        }
      } catch (e) {
        log("✅ Success: JSON parsing failed but status code indicates success");
        return const Right(null);
      }
    } else {
      // Handle error responses
      dynamic responseData;
      try {
        responseData = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      } catch (e) {
        responseData = {};
      }

      String errorMessage;
      switch (response.statusCode) {
        case 400:
          errorMessage = "Bad Request: ${responseData["message"] ?? "Invalid ticket ID"}";
          break;
        case 401:
          errorMessage = "Unauthorized: Please login again.";
          break;
        case 403:
          errorMessage = "Forbidden: You don't have permission to cancel this ticket.";
          break;
        case 404:
          errorMessage = "Ticket not found or already cancelled.";
          break;
        case 422:
          errorMessage = "Validation Error: ${responseData["message"] ?? "Invalid ticket data"}";
          break;
        case 500:
          errorMessage = "Internal Server Error: ${responseData["message"] ?? "Please try again later."}";
          break;
        default:
          errorMessage = "Error ${response.statusCode}: ${responseData["message"] ?? "Unknown error"}";
      }
      
      log("❌ Error: $errorMessage");
      return Left(ServerFailure(message: errorMessage));
    }
  } catch (e) {
    log("❌ Exception in cancelRequestEventFromRemoteDataSource: $e");
    return Left(ServerFailure(message: "Network error: ${e.toString()}"));
  }
}
}