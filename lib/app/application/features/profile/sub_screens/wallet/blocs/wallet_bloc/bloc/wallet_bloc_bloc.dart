import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/wallet_response_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/wallet_usecases.dart';

part 'wallet_bloc_event.dart';
part 'wallet_bloc_state.dart';

class WalletBlocBloc extends Bloc<WalletBlocEvent, WalletBlocState> {
  final WalletUsecases walletUsecases = WalletUsecases();
  WalletBlocBloc() : super(WalletBlocInitial()) {
    on<GetWalletRequestEvent>((event, emit) async{
     emit(GetWalletLoadingState());

      final result = await walletUsecases.getAllWalletDetails();

      result.fold((failure){
        emit(GetWalletFailureState(errorMessage: failure.message));
      }, (resposeData){
        emit(GetWalletSuccessState(walletData: resposeData.walletData!));
      });
    });
  }
}
