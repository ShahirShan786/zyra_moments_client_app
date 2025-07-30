// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;


// /// This function retries an API request if the token is expired and refresh succeeds.
// Future<http.Response> retryWithTokenRefresh({
//   required Future<http.Response> Function(String accessToken) request,
// }) async {
//   String accessToken = await SecureStorageHelper.getAccessToken();

//   // First attempt
//   http.Response response = await request(accessToken);

//   // If token expired (401), try refreshing it
//   if (response.statusCode == 401) {
//     log("Access token expired. Trying to refresh...");

//     final refreshResult = await TokenRefreshService().refreshAccessToken();

//     return await refreshResult.fold(
//       (failure) {
//         log("Token refresh failed: ${failure.message}");
//         return Future.value(response); // Return original failed response
//       },
//       (tokens) async {
//         final newAccessToken = tokens['access_token']!;
//         log("Token refresh succeeded. Retrying original request...");
//         return await request(newAccessToken); // Retry with new token
//       },
//     );
//   }

//   return response; // Return original response if 200 or other than 401
// }
