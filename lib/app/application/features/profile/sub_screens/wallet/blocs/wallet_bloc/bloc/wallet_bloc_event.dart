part of 'wallet_bloc_bloc.dart';

sealed class WalletBlocEvent extends Equatable {
  const WalletBlocEvent();

  @override
  List<Object> get props => [];
}


class GetWalletRequestEvent extends WalletBlocEvent{
  
}