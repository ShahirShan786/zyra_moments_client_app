
import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/domain/entities/login_entity.dart' show ActiveUser;

abstract class LoginRepository {
  Future<Either<Failure , ActiveUser>> login(String email , String password);
}