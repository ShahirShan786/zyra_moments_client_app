part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendotpEvent extends ForgotPasswordEvent{
  final String email;

  const SendotpEvent(this.email);

  
  @override
  List<Object> get props => [email];
}

class ResendOtpEvent extends ForgotPasswordEvent{
  final String email;

  const ResendOtpEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class VerifyotpEvent extends ForgotPasswordEvent{
  final String email;
  final String otp;

  const VerifyotpEvent(this.email, this.otp);

   @override
  List<Object> get props => [email , otp];
  
}

class ResetPasswordEvent extends ForgotPasswordEvent{
  final String email;
  final String newPassword;

  const ResetPasswordEvent(this.email, this.newPassword);

  @override
  List<Object> get props => [email , newPassword];
}

class TimerTickingEvent extends ForgotPasswordEvent{
  final int secondsLeft;

  const TimerTickingEvent({required this.secondsLeft});



    @override
  List<Object> get props => [secondsLeft];
}