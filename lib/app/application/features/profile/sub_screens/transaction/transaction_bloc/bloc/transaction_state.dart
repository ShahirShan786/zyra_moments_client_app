part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();
  
  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class GetTransactionLoadingState extends TransactionState{

}

final class GetTransactionSuccessState extends TransactionState{
  final List<Payment> transactionPayment;

const  GetTransactionSuccessState({required this.transactionPayment}); 

  @override
  List<Object> get props => [transactionPayment];
}


final class GetTransactionFailureState extends TransactionState{
  final String errorMessage;

 const GetTransactionFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}