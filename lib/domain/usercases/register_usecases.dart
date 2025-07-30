import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/domain/entities/login_entity.dart';
import 'package:zyra_momments_app/domain/entities/sign_up_entity.dart';
import 'package:zyra_momments_app/domain/repository/sing_up_repository.dart';

class RegisterUsecases {
  
  final SingUpRepository singUpRepository;

  RegisterUsecases({required this.singUpRepository});

  Future<String> call(User user)async{
    return await singUpRepository.register(user);
  }
   Future<Either<Failure, ActiveUser>> callRegisterWithGoogle()async{
    return await singUpRepository.registerWithGoogle();
  }
}