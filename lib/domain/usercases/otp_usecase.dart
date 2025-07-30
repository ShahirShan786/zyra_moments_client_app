import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/repository/otp_repository_impl.dart';
import 'package:zyra_momments_app/domain/entities/otp_entity.dart';
import 'package:zyra_momments_app/domain/repository/otp_repository.dart';

class OtpUsecases {
  OtpRepository otpRepository = OtpRepositoryImpl();

  Future<Either<Failure , OtpEntity>> call(String email){
    return otpRepository.sendOtp(email);
  }
  Future<Either<Failure , OtpEntity>> verifyCall(String email , String otp){
    return otpRepository.verifyOTP(email, otp);
  }
}