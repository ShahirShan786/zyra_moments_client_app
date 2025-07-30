part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final bool isPasswordVisible;

  const LoginInitial({this.isPasswordVisible = false});

  @override
  List<Object> get props => [isPasswordVisible];
}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  final ActiveUser user;

  const LoginStateSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginStateFailure extends LoginState {
  final String errorMessage;

  const LoginStateFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// Specific error states for better UX
class LoginStateNetworkError extends LoginState {
  final String errorMessage;

  const LoginStateNetworkError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class LoginStateAuthenticationError extends LoginState {
  final String errorMessage;

  const LoginStateAuthenticationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class LoginStateValidationError extends LoginState {
  final String errorMessage;

  const LoginStateValidationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}














// part of 'login_bloc.dart';

// sealed class LoginState extends Equatable {
//   const LoginState();
  
//   @override
//   List<Object> get props => [];
// }

// final class LoginInitial extends LoginState {
//    final bool isPasswordVisible;

//  const LoginInitial({ this.isPasswordVisible = false});
  
//   @override
//   List<Object> get props => [isPasswordVisible];
// }


// final class LoginStateLoading extends LoginState{}

// final class LoginStateSuccess extends LoginState{
//   final ActiveUser user;

//   const LoginStateSuccess({required this.user});

//    @override
//   List<Object> get props => [user];
// }


// final class LoginStateFailure extends LoginState{
//   final String message;

//   const LoginStateFailure(this.message);
  
//    @override
//   List<Object> get props => [message];
// }