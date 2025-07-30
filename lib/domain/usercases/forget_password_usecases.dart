import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

import 'package:zyra_momments_app/data/repository/forgot_password_repository_impl.dart';
import 'package:zyra_momments_app/domain/repository/forget_password_repository.dart';

class ForgetPasswordUsecases {
  final ForgetPasswordRepository forgetPasswordRepository = ForgotPasswordRepositoryImpl();

  Future<Either<Failure , void>> sendOTpCall(String email){
    return forgetPasswordRepository.sendOTp(email);
  }

  Future<Either<Failure , void>> verifyOtpCall(String email , String otp){
    return forgetPasswordRepository.verifyOTP(email, otp);
  }

  Future<Either<Failure , void>> resetPasswordCall(String email , String newPassword){
    return forgetPasswordRepository.resetPassword(email, newPassword);
  }
}
