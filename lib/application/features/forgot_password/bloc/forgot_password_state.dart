part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  
  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class OtpLoading extends ForgotPasswordState{
  final double progress;

  const OtpLoading({required this.progress});

   @override
  List<Object> get props => [progress];
}

final class OtpSendState extends ForgotPasswordState{}

final class OtpVerifySuccessState extends ForgotPasswordState{
  // final String message;

  // OtpVerifySuccessState({required this.message});

  // @override
  // List<Object> get props => [message];
}

final class OtpfailureState extends ForgotPasswordState{
  final String errorMessage;

  const OtpfailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class LoadingState extends ForgotPasswordState{}

final class PasswordResetSuccessState extends ForgotPasswordState{}

final class PasswordResetFailureState extends ForgotPasswordState{
  final String message;

  const PasswordResetFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class OtpTimeRunnig extends ForgotPasswordState{
  final int secondsLeft;

  const OtpTimeRunnig({required this.secondsLeft});

  @override
  List<Object> get props => [secondsLeft];
}