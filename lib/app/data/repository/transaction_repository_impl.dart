import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/transaction_remote_data_source.dart';
import 'package:zyra_momments_app/app/data/models/transaction_response_model.dart';
import 'package:zyra_momments_app/app/domain/repository/transaction_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class TransactionRepositoryImpl implements TransactionRepository{
  final TransactionRemoteDataSource transactionRemoteDataSource = TransactionRemoteDataSourceImpl();

  @override
  Future<Either<Failure, TransactionResponseModel>> getAllTransactionDetails() async{
   return transactionRemoteDataSource.getAllRemoteTransactionDetails();
  }
  
}