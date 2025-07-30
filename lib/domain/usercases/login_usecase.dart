
import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/repository/login_repository_impl.dart';
import 'package:zyra_momments_app/domain/entities/login_entity.dart';
import 'package:zyra_momments_app/domain/repository/login_repository.dart';

class LoginUsecase {
  LoginRepository loginRepository = LoginRepositoryImpl();
  Future<Either<Failure , ActiveUser>> call(String email , String password){
    return loginRepository.login(email, password);
  }
}