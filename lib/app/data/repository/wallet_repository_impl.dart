import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/wallet_remote_data_source.dart';
import 'package:zyra_momments_app/app/data/models/wallet_response_model.dart';
import 'package:zyra_momments_app/app/domain/repository/wallet_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class WalletRepositoryImpl implements WalletRepository{
  final WalletRemoteDataSource walletRemoteDataSource = WalletRemoteDataSourceImpl();
  @override
  Future<Either<Failure, WalletResponseModel>> getAllWalletDetails() {
    
   return walletRemoteDataSource.getWalletDetails();
  }
  
}