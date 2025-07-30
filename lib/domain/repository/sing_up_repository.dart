import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/domain/entities/login_entity.dart';
import 'package:zyra_momments_app/domain/entities/sign_up_entity.dart';

abstract class SingUpRepository {
  Future<String> register(User user);
  Future<Either<Failure , ActiveUser>> registerWithGoogle();
}