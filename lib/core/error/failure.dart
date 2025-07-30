// import 'package:equatable/equatable.dart';

// abstract class Failure extends Equatable {
//   final String message;

//   const Failure({this.message = "An unexpected error occurred"});
//   @override
//   List<Object?> get props => [message];
// }

// class ServerFailure extends Failure {
//   @override
//   final String message;

//   const ServerFailure({required this.message});
//    @override
//   List<Object?> get props => [message];
// }

// class NetworkFailure extends Failure {}



import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = "An unexpected error occurred"});
  
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  @override
  final String message;

  const ServerFailure({required this.message});
  
  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  @override
  final String message;

  const NetworkFailure({required this.message});
  
  @override
  List<Object?> get props => [message];
}

class AuthenticationFailure extends Failure {
  @override
  final String message;

  const AuthenticationFailure({required this.message});
  
  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  @override
  final String message;

  const ValidationFailure({required this.message});
  
  @override
  List<Object?> get props => [message];
}