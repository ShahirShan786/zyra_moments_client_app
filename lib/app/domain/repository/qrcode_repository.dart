import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class QrcodeRepository {
  Future<Either<Failure , void>> sendQrcodeinfo();
}