import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';

import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';
import 'package:zyra_momments_app/data/repository/api_repository.dart';

abstract class CategoryRemoteDataSource {
  Future<Either<Failure, List<Categories>>> getCategories();
  // the get vendor fucntion should replace to the app folder.
  Future<Either<Failure, List<Vendor>>> getvendorCategory({required String categoryId , String search = ''});
}

class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  final client = http.Client();
  ApiRepository apiRepository = ApiRepository();

  Future<String?> refreshAccessToken() async {
    final user = await SecureStorageHelper.loadUser();
    final refreshToken = user["refresh_token"];
    final accessToken = user["access_token"];
    log("Actual accesstoken **** : $accessToken");

    if (accessToken == null || refreshToken == null) {
      print('Tokens missing');
      return null;
    }

    final url = Uri.parse(
        '${ApiKey().baseUrl}${ApiKey().clientNpoint}refresh-token'); // Your refresh URL

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie':
            'client_access_token=$accessToken', // 🍪 Set access token in cookie
      },
      // body: jsonEncode({
      //   'refreshToken': refreshToken, // Assuming your backend expects this in the body
      // }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['token'];
      log("newAccessToken =$newAccessToken");
      // final newRefreshToken = data['refreshToken'];

      //  await SecureStorageHelper.saveUser(
      //       accessToken: newAccessToken,
      //       refreshToken: newRefreshToken,
      //       firstName: user['first_name']!,
      //       lastName: user['last_name']!,
      //       email: user['email']!,
      //       role: user['role']!,
      //     );

      print('Access token refreshed successfully');
      return newAccessToken;
    } else {
      print('Failed to refresh token: ${response.body}');
      return null;
    }
  }

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    log("Entered the category  function");
    try {
      final user = await SecureStorageHelper.loadUser();

      final accessToken = user['access_token'];

      final response = await client.get(
        Uri.parse(
            "${ApiKey().baseUrl}${ApiKey().clientNpoint}${ApiKey().getCategories}"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );

      // If the token has expired (assume status code 401 means expired token)
      if (response.statusCode == 401) {
        // Refresh the access token
        final accessToken = await apiRepository.refreshAccessToken();

        // Retry the original request with the new access token
        final retryResponse = await client.get(
          Uri.parse(
              "${ApiKey().baseUrl}${ApiKey().clientNpoint}${ApiKey().getCategories}"),
          headers: {
            'Cookie': 'client_access_token=$accessToken',
            'Content-Type': 'application/json',
          },
        );

        // Handle the retry response
        return _handleResponse(retryResponse);
      }

      // If the token is valid, handle the initial response
      return _handleResponse(response);
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }

// Helper function to handle the API response and parse data
  Either<Failure, List<Categories>> _handleResponse(http.Response response) {
    try {
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['success'] == true) {
        final categoryModel = CategoryModel.fromJson(responseData);
        return Right(categoryModel.categories);
      } else {
        return Left(ServerFailure(message: responseData['message']));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Error parsing response: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<Vendor>>> getvendorCategory({required String categoryId , String search = ''}) async {
    log("Given category id is : $categoryId");
    log("Entered GetvendorCategory function");

    try {
      // final response = await apiRepository.performRequestWithRefresh((accessToken) {
      //   return client.get(
      //     Uri.parse("https://www.api.zyramoments.in/api/v_1/_pvt/_cl/client/vendors/$categoryId/listing?page=1&limit=1&search=&sortBy=name_asc"),
      //     headers: {
      //       'Cookie': 'client_access_token=$accessToken',
      //       'Content-Type': 'application/json',
      //     },
      //   );
      // });
      final user = await SecureStorageHelper.loadUser();

      final accessToken = user['access_token'];
      final response = await client.get(
        Uri.parse(
            "${ApiKey().baseUrl}${ApiKey().clientNpoint}vendors/$categoryId/listing?page=1&limit=10&search=$search&sortBy=name_asc"),
        headers: {
          'Cookie': 'client_access_token=$accessToken',
          'Content-Type': 'application/json',
        },
      );
      // If the token has expired (assume status code 401 means expired token)
      if (response.statusCode == 401) {
        // Refresh the access token
        final accessToken = await apiRepository.refreshAccessToken();

        // Retry the original request with the new access token
        final retryResponse = await client.get(
          Uri.parse(
              "${ApiKey().baseUrl}${ApiKey().clientNpoint}${ApiKey().getCategories}"),
          headers: {
            'Cookie': 'client_access_token=$accessToken',
            'Content-Type': 'application/json',
          },
        );

        // Handle the retry response
        return _handleVendorCategoryResponse(retryResponse);
      }

      // If the token is valid, handle the initial response
      return _handleVendorCategoryResponse(response);
    } catch (e) {
      return Left(
          ServerFailure(message: "Exception Occurred: ${e.toString()}"));
    }
  }

  Either<Failure, List<Vendor>> _handleVendorCategoryResponse(
      http.Response response) {
    try {
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['success'] == true) {
        log("${response.statusCode}");
        log(response.body);
        final vendorResponse = VendorResponse.fromJson(responseData);
        return Right(vendorResponse.vendors);
      } else {
        return Left(ServerFailure(message: responseData['message']));
      }
    } catch (e) {
      return Left(
          ServerFailure(message: "Error parsing response: ${e.toString()}"));
    }
  }
}
