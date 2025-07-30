import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/wallet_response_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class WalletRepository {
  Future<Either<Failure , WalletResponseModel>> getAllWalletDetails();
}