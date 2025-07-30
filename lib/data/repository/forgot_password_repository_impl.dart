import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/data_source/forgot_password_data_source.dart';

import 'package:zyra_momments_app/domain/repository/forget_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgotPasswordDataSource forgotPasswordDataSource =
      ForgotPasswordDataSourceImpl();

  @override
  Future<Either<Failure, void>> sendOTp(String email) async {
    return await forgotPasswordDataSource.sendOTP(email);
  }

  @override
  Future<Either<Failure, void>> verifyOTP(String email, String otp) async{
     return await forgotPasswordDataSource.verifyOtp(email, otp);
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email, String newPassword) async{
    return await forgotPasswordDataSource.resetPassword(email, newPassword);
  }
}
