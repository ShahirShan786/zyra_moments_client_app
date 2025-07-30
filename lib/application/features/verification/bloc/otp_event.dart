part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class SendOTPEvent extends OtpEvent {
  final String email;

  const SendOTPEvent({required this.email});
  @override
  List<Object> get props => [email];
}



class VerifyOTPEvent extends OtpEvent {
  final String email;
  final String otp;

  const VerifyOTPEvent({required this.email, required this.otp});
  @override
  List<Object> get props => [email, otp];
}

class ResendOTPEvent extends OtpEvent{
  final String email;

  const ResendOTPEvent({required this.email});
  
}

class TimerTickerEvent extends OtpEvent{
  final int secondsLeft;

  const TimerTickerEvent({required this.secondsLeft});
}
