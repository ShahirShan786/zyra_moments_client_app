import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/wallet_response_model.dart';
import 'package:zyra_momments_app/app/data/repository/wallet_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/wallet_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class WalletUsecases {
  final WalletRepository walletRepository = WalletRepositoryImpl();
  Future<Either<Failure , WalletResponseModel>> getAllWalletDetails(){
  return walletRepository.getAllWalletDetails();
  }
}