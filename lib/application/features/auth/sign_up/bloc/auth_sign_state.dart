part of 'auth_sign_bloc.dart';

sealed class AuthSignState extends Equatable {
  const AuthSignState();
  
  @override
  List<Object> get props => [];
}

final class AuthSignInitial extends AuthSignState {
    final bool isPasswordVisible;

 const AuthSignInitial({ this.isPasswordVisible = false});
  @override
  List<Object> get props => [isPasswordVisible];
}

final class FirstPageSaved extends AuthSignState{
  final String firstName;
  final String lastName;
  final String phone;

  const FirstPageSaved({required this.firstName, required this.lastName, required this.phone});

  @override
  List<Object> get props => [firstName , lastName , phone]; 
}


final class AuthSignStateLoading extends AuthSignState{}

final class AuthSignStateSuccess extends AuthSignState{}


final class AuthSignStateFailure extends AuthSignState{
  final String errorMessage;

  const AuthSignStateFailure({required this.errorMessage});

 @override
  List<Object> get props => [errorMessage]; 
  
}



final class AuthSignGoogleStateLoading extends AuthSignState{}

final class AuthSignGoogleStateSuccess extends AuthSignState{
   final ActiveUser user;

 const AuthSignGoogleStateSuccess({required this.user});
}

final class AuthSignGoogleStateFailure extends AuthSignState{
  final String errorMessage;

  const AuthSignGoogleStateFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage]; 
}