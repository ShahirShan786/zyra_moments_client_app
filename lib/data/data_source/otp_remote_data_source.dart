import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/data/models/otp_model.dart';

abstract class OtpRemoteDataSource {
  Future<OtpModel> sendOtp(String email);
  Future<OtpModel> verifyOTP(String email, String otp);
}

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  final client = http.Client();

  // OtpRemoteDataSourceImpl({required this.client)
  @override
  Future<OtpModel> sendOtp(String email) async {
    log(email);
    log("Entered the fuction");
    try {
      final response = await client.post(
          Uri.parse("${ApiKey().baseUrl}${ApiKey().nPoint}send-otp"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email}));
      if (response.statusCode == 200) {
        log("${response.statusCode}");
        log(response.body);
        // final Map<String, dynamic> responseData = jsonDecode(response.body);
        // return Right(OtpModel.fromJson(responseData["message"]));
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return OtpModel.fromJson(responseData);
      } else {
        throw Exception("Fail to fetch data ");
      }
    } catch (e, stackTrace) {
      log("Error : $e");
      log("Stack Trace : $stackTrace");
      rethrow;
    }
  }

  @override
  Future<OtpModel> verifyOTP(String email, String otp) async {
    Map<String, dynamic> data = {"email": email, "otp": otp};
    log("entered verification fuction");
    log("email : $email , otp : $otp");
    try {
      final response = await client.post(
          Uri.parse("${ApiKey().baseUrl}${ApiKey().nPoint}verify-otp"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        log("${response.statusCode}");
        log(response.body);
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return OtpModel.fromJson(responseData);
      } else {
        throw Exception(
            "Fail to fetch data with status code ${response.statusCode}");
      }
    } catch (e) {
      log("Error decoding response: $e");
      throw Exception("something went wrong...");
    }
  }
}
