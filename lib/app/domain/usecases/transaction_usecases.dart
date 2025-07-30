import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/transaction_response_model.dart';
import 'package:zyra_momments_app/app/data/repository/transaction_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/transaction_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class TransactionUsecases {
   final TransactionRepository transactionRepository = TransactionRepositoryImpl();
  Future<Either<Failure , TransactionResponseModel>> callGetAllTransactionDetails(){
    return transactionRepository.getAllTransactionDetails();
  }
}