import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';


abstract class ForgetPasswordRepository {
   Future<Either<Failure , void>> sendOTp(String email);
   Future<Either<Failure , void>> verifyOTP(String email , String otp);
   Future<Either<Failure , void>> resetPassword(String email , String newPassword);
}
