import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart'as http;
import 'package:zyra_momments_app/application/core/api/api_keys.dart';

abstract class LogOutRemoteDataSource {
  Future<void> logOut(String accessToken , String refreshToken);
}
class LogOutRemoteDataSourceImpl implements LogOutRemoteDataSource {
  final client = http.Client();

  @override
  Future<void> logOut(String accessToken, String refreshToken) async {
    log("Entered the logout function");
    log("accessToken for api: $accessToken");
    log("refreshToken for api: $refreshToken");

    try {
      final response = await client.post(
        Uri.parse("${ApiKey().baseUrl}${ApiKey().clientNpoint}logout"),
        headers: {
          'Cookie': 'client_access_token=$accessToken; client_refresh_token=$refreshToken',
          'Content-Type': 'application/json',
        },
      );

      log("Logout response status: ${response.statusCode}");
      log("Logout response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        log("Logout successful: ${responseData['message']}");
        return;
      } else if (response.statusCode == 403 &&
          response.body.contains("Token is blacklisted")) {
        log("Token already blacklisted — treating as successful logout.");
        return;
      } else {
        log("Logout failed with status ${response.statusCode}: ${response.body}");
        throw Exception("Logout failed: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      log("Logout error: $e");
      throw Exception('Logout error: $e');
    }
  }
}
