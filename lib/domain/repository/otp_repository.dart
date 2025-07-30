import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/domain/entities/otp_entity.dart';



abstract class OtpRepository {
  Future<Either<Failure , OtpEntity>> sendOtp(String email);
  Future<Either<Failure, OtpEntity>> verifyOTP(String email, String otp);
}