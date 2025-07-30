import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/application/features/verification/bloc/otp_state.dart';
import 'package:zyra_momments_app/data/repository/otp_repository_impl.dart';
import 'package:zyra_momments_app/domain/repository/otp_repository.dart';

part 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpRepository otpRepository = OtpRepositoryImpl();
  Timer? _timer;
  int countdown = 60;

  OtpBloc({required this.otpRepository}) : super(OTPInitial()) {
    on<SendOTPEvent>((event, emit) async {
      for (double i = 0.0; i <= 1.0; i += 0.2) {
        await Future.delayed(Duration(milliseconds: 400));
        emit(OTPLoading(progress: i));
      }

      final result = await otpRepository.sendOtp(event.email);
      result.fold(
        (failure) => emit(OTPFailure(error: "Failed to send OTP")),
        (otp) {
          emit(OtpUsuccess(message: otp.message));
          _startTimer(emit);
        },
      );
    });

    on<VerifyOTPEvent>((event, emit) async {
      emit(OTPVerificationLoading());
      final result = await otpRepository.verifyOTP(event.email, event.otp);

      result.fold((failure) {
        emit(OTPVerificationFailure(error: "Invalid OTP"));
      }, (otp) {
        _timer?.cancel();
        emit(OTPVerificationSuccess(message: otp.message));
      });
    });

    on<ResendOTPEvent>((event, emit) async {
      countdown = 60;
      add(SendOTPEvent(email: event.email));
    });

    on<TimerTickerEvent>((event, emit) {
      if (event.secondsLeft > 0) {
        emit(OTPTimeRunnig(secondsLeft: event.secondsLeft));
      } else if (state is! OTPFailure) {
        emit(OTPFailure(error: "OTP expired. plese try again."));
      }
    });
  }

  void _startTimer(Emitter<OtpState> emit) {
    _timer?.cancel();
    countdown = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown <= 0) {
        _timer?.cancel();
        _timer = null;  
        if (state is! OTPFailure) {
          add(TimerTickerEvent(secondsLeft: 0));
        }
      } else {
        countdown--;
        add(TimerTickerEvent(secondsLeft: countdown));
      }
    });
  }
}
