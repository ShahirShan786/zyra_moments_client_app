import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/data_source/otp_remote_data_source.dart';
import 'package:zyra_momments_app/domain/entities/otp_entity.dart';
import 'package:zyra_momments_app/domain/repository/otp_repository.dart';


class OtpRepositoryImpl implements OtpRepository{

  final OtpRemoteDataSource otpRemoteDataSource = OtpRemoteDataSourceImpl();
  @override
  Future<Either<Failure, OtpEntity>> sendOtp(String email) async{
   try{
     final response = await otpRemoteDataSource.sendOtp(email);
  log("the otp respose is ....$response");
    return Right(response);
   }catch(e){
    return Left(ServerFailure(message: "Fail to otp send"));
   }
    
  }

  @override
  Future<Either<Failure, OtpEntity>> verifyOTP(String email, String otp)async {
     try{
        final response = await otpRemoteDataSource.verifyOTP(email, otp);
        log(response.message);

        return Right(response);
     }catch(e){
        return Left(ServerFailure(message: "Fail to fetch datass"));
     }
   
  }
}