import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zyra_momments_app/application/core/user_info.dart'; // SecureStorageHelper

class ApiRepository {
  Future<http.Response> performRequestWithRefresh(

    Future<http.Response> Function(String accessToken) requestFn,
  ) async {
    log("entered the porefomReqeustWIthRefresh Function......");
    final user = await SecureStorageHelper.loadUser();
    String accessToken = user["access_token"]!;
    log("🔁 Performing API request with access token: $accessToken");
    http.Response response = await requestFn(accessToken);
    log("📥 Response status: ${response.statusCode}");
    if (response.statusCode == 401) {
      log("⚠️ Token expired, attempting to refresh...");
      final refreshSuccessful = await refreshAccessToken();

      if (refreshSuccessful) {
        final newUser = await SecureStorageHelper.loadUser();
        if (newUser["access_token"] == null) {
          log("❌ New access token is null after refresh");
          await SecureStorageHelper.clearUser();
          throw Exception("Session expired. Please log in again.");
        }
        String newAccessToken = newUser["access_token"]!;
        log("✅ Retrying request with new access token: $newAccessToken");
        response = await requestFn(newAccessToken);
      } else {
        log("❌ Token refresh failed");
        await SecureStorageHelper.clearUser();
        throw Exception("Session expired. Please log in again.");
      }
    }

    return response;
  }

  Future<bool> refreshAccessToken() async {
    try {
       log("entered the refreshAccessToken Function......");
      final user = await SecureStorageHelper.loadUser();
      final refreshToken = user["refresh_token"];
      final accessToken = user['access_token'];
      log("accessToken ######## : $accessToken");

      if (refreshToken == null || accessToken == null) {
        log("❌ Missing refresh or access token");
        return false;
      }

      final response = await http.post(
        Uri.parse(
            "https://www.api.zyramoments.in/api/v_1/_pvt/_cl/client/refresh-token"),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'client_access_token=$accessToken',
        },
        // body: jsonEncode({'refresh_token': refreshToken}),
      );
         
          final jsonBody = jsonDecode(response.body);
      if (response.statusCode == 200 && jsonBody['success'] == true) {
        log(" refresh response : ${response.statusCode}");
        log(response.body);
       
        final newAccessToken = jsonBody['token'];
        log("New AccessToken #: $newAccessToken ");

        if (newAccessToken == null) {
          log("❌ Token not found in response body");
          return false;
        }

        // Save the new access token and reuse the existing refresh token
        await SecureStorageHelper.saveUser(
          accessToken: newAccessToken,
          refreshToken: refreshToken, // same old refresh token
          firstName: user['first_name']!,
          lastName: user['last_name']!,
          email: user['email']!,
          role: user['role']!,
          id: user['id']!,
        );

        log("✅ Tokens refreshed from response body");
        return true;
      } else {
        log("⚠️ Token refresh failed with status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("❌ Token refresh exception: $e");
      return false;
    }
  }
}
