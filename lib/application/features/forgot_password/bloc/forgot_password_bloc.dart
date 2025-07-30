import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/data/repository/forgot_password_repository_impl.dart';
import 'package:zyra_momments_app/domain/repository/forget_password_repository.dart';
import 'package:zyra_momments_app/domain/usercases/forget_password_usecases.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgetPasswordRepository forgetPasswordRepository =
      ForgotPasswordRepositoryImpl();
  final ForgetPasswordUsecases forgetPasswordUsecases =
      ForgetPasswordUsecases();
  Timer? _timer;
  int countdown = 60;

  ForgotPasswordBloc(this.forgetPasswordRepository)
      : super(ForgotPasswordInitial()) {
    on<SendotpEvent>(_sendOtp);
    on<VerifyotpEvent>(_verifyOtp);
    on<TimerTickingEvent>(_otpTimeRunning);
    on<ResetPasswordEvent>(_resetPassword);
    on<ResendOtpEvent>(_resendOtp);
  }

  void _sendOtp(SendotpEvent event, Emitter<ForgotPasswordState> emit) async {
    for (double i = 0.0; i <= 1.0; i += 0.2) {
      await Future.delayed(Duration(milliseconds: 300));
      emit(OtpLoading(progress: i));
    }

    final result = await forgetPasswordUsecases.sendOTpCall(event.email);

    result.fold((failure) => emit(OtpfailureState(errorMessage: failure.message)),
        (_) {
      emit(OtpSendState());
      _startTimer(emit);
    });
  }

  void _verifyOtp(
      VerifyotpEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(LoadingState());

    final result =
        await forgetPasswordUsecases.verifyOtpCall(event.email, event.otp);

    result.fold((failure) => emit(PasswordResetFailureState(failure.message)),
        (_) {
      _timer?.cancel();
      emit(OtpVerifySuccessState());
    });
  }

  void _otpTimeRunning(
      TimerTickingEvent event, Emitter<ForgotPasswordState> emit) {
    if (event.secondsLeft > 0) {
      emit(OtpTimeRunnig(secondsLeft: event.secondsLeft));
    } else {
      emit(OtpfailureState(
          errorMessage: "OTP has expired. Please request a new one."));
    }
  }

  void _resetPassword(
      ResetPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(LoadingState());

    final result = await forgetPasswordUsecases.resetPasswordCall(
        event.email, event.newPassword);

    result.fold((failure) => emit(PasswordResetFailureState(failure.message)),
        (_) => emit(PasswordResetSuccessState()));
  }

  void _resendOtp(ResendOtpEvent event, Emitter<ForgotPasswordState> emit) {
    countdown = 60;
    add(SendotpEvent(event.email));
  }

  void _startTimer(Emitter<ForgotPasswordState> emit) {
    _timer?.cancel();
    countdown = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown <= 0) {
        _timer?.cancel();
        add(TimerTickingEvent(secondsLeft: 0));
      } else {
        countdown--;
        add(TimerTickingEvent(secondsLeft: countdown));
      }
    });
  }
}
