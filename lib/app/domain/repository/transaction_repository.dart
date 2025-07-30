import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/transaction_response_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class TransactionRepository {
  Future<Either<Failure , TransactionResponseModel>> getAllTransactionDetails();
}