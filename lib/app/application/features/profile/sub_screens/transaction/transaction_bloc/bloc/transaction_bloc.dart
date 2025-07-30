import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/transaction_response_model.dart';

import 'package:zyra_momments_app/app/domain/usecases/transaction_usecases.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionUsecases transactionUsecases = TransactionUsecases();
  TransactionBloc() : super(TransactionInitial()) {

    on<GetAllTransactionRequest>((event, emit) async{
      emit(GetTransactionLoadingState());

      final result = await transactionUsecases.callGetAllTransactionDetails();

      result.fold((failure){
        emit(GetTransactionFailureState(errorMessage: failure.message));
      }, (result){
        emit(GetTransactionSuccessState(transactionPayment: result.payments));
      });
    });
  }
}
