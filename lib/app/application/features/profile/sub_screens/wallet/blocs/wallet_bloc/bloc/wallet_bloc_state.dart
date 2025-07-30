part of 'wallet_bloc_bloc.dart';

sealed class WalletBlocState extends Equatable {
  const WalletBlocState();
  
  @override
  List<Object> get props => [];
}

final class WalletBlocInitial extends WalletBlocState {}

final class GetWalletLoadingState extends WalletBlocState{}

final class GetWalletSuccessState extends WalletBlocState{
  final WalletData walletData;

 const GetWalletSuccessState({required this.walletData});

  @override
  List<Object> get props => [walletData];
}

final class GetWalletFailureState extends WalletBlocState{
  final String errorMessage;

const  GetWalletFailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

