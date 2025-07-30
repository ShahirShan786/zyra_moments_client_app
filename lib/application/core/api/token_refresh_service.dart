import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zyra_momments_app/application/core/user_info.dart';


class TokenRefreshService {
  static Future<String?> refreshAccessToken() async {
    try {
    final response = await http.post(
        Uri.parse("https://api.zyramoments.in/api/v_1/_pvt/_cl/client/refresh-token"),
        headers: {'Content-Type': 'application/json'},
        // body: jsonEncode({'refreshToken': refreshToken}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        final newAccessToken = responseData['accessToken'];

        await SecureStorageHelper.storage.write(
          key: SecureStorageHelper.keyAccessToken,
          value: newAccessToken,
        );

       

        return newAccessToken;
      } else {
        throw TokenRefreshException(
          responseData['message'] ?? 'Failed to refresh token',
        );
      }
    } catch (e) {
      throw TokenRefreshException("Refresh failed: $e");
    }
  }
}

class TokenRefreshException implements Exception {
  final String message;
  TokenRefreshException(this.message);
}
