part of 'log_out_bloc.dart';

sealed class LogOutState extends Equatable {
  const LogOutState();
  
  @override
  List<Object> get props => [];
}

final class LogOutInitial extends LogOutState {}


final class LogOutLoadingState extends LogOutState{}

final class LogOutSuccessState extends LogOutState{}

final class LogOutFailureState extends LogOutState{
  final String errorMessage;

 const LogOutFailureState({required this.errorMessage});

   @override
  List<Object> get props => [errorMessage];
}