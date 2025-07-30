import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable{

  @override
  List<Object?> get props => [];
}

class OTPInitial extends OtpState{}

class OTPLoading extends OtpState{
  final double progress;

  OTPLoading({required this.progress});
  @override
  List<Object?> get props => [progress];
}

class OtpUsuccess extends OtpState{
  final String message;

  OtpUsuccess({required this.message});

  @override
  List<Object?> get props => [message];
  
}

class OTPFailure extends OtpState{
  final String error;

  OTPFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class OTPTimeRunnig extends OtpState{
  final int secondsLeft;

  OTPTimeRunnig({required this.secondsLeft});

   @override
  List<Object?> get props => [secondsLeft];
}

class OTPVerificationLoading extends OtpState{

}

class OTPVerificationSuccess extends OtpState{
  final String message;

  OTPVerificationSuccess({required this.message});

   @override
  List<Object?> get props => [message];
}

class OTPVerificationFailure extends OtpState{
  final String error;

  OTPVerificationFailure({required this.error});

   @override
  List<Object?> get props => [error];
}
