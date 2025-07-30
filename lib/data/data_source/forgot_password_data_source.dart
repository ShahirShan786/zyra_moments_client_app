import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:http/http.dart' as http;


abstract class ForgotPasswordDataSource {
  Future<Either<Failure, void>> sendOTP(String email);
  Future<Either<Failure ,void>> verifyOtp(String email, String otp);
  Future<Either<Failure , void>> resetPassword(String email , String newPassword);
}

class ForgotPasswordDataSourceImpl extends ForgotPasswordDataSource {
  var client = http.Client();
  @override
  Future<Either<Failure, void>> sendOTP(String email) async {
    log("Entered the funcntion");
    final data = {'email': email};
    try {
       log("Sending request  with data: $data");
      final response = await client.post(
          Uri.parse(
            "${ApiKey().baseUrl}${ApiKey().nPoint}verify-email",
          ),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));

      final resposedata = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200) {
        if (resposedata['success'] == true) {
          return Right(null);
        } else {
          
          return Left(ServerFailure(message: resposedata['message']));
        }
      } else {
        
        return Left(ServerFailure(message: resposedata['message']));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> verifyOtp(String email, String otp) async{
    log("Enter verify otp fuction");
      final data = {
        'email' : email,
        'otp'  : otp
      };
     try{
       log("Sending request  with data: $data");
       final response = await client.post(Uri.parse("${ApiKey().baseUrl}${ApiKey().nPoint}verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));

           final responseData = jsonDecode(response.body);
           log(response.body);

          if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          return Right(responseData);
        } else {
          return Left(ServerFailure(message: responseData['message']));
        }
      } else {
        return Left(ServerFailure(message: "Something went wrong. Please try again."));
      }
     }catch(e){
      return Left(ServerFailure(message: e.toString()));
     }
  }
  
  @override
  Future<Either<Failure, void>> resetPassword(String email, String newPassword) async{
    log("entered the password reset fuction fuction");
     final data ={
      'email' : email,
      'newPassword' : newPassword,
      'role' : 'client'
     };

    try{

      final response = await client.patch(Uri.parse("${ApiKey().baseUrl}${ApiKey().nPoint}password"),
       headers: {"Content-Type": "application/json"},
       body: jsonEncode(data)
      );
     
       final responseData = jsonDecode(response.body);
        if(response.statusCode == 200){
          if(responseData['success'] == true){
            return Right(null);
          }else{
            return Left(ServerFailure(message: responseData['message']));
          }
        }else{
          return Left(ServerFailure(message: "Unexpected error occurred"));
        }
    }catch(e){
       return Left(ServerFailure(message: e.toString()));
    }
   
  }
}


