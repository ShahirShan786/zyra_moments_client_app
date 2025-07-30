import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/domain/usercases/log_out_usecases.dart';

part 'log_out_event.dart';
part 'log_out_state.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  LogOutUsecases logOutUsecases = LogOutUsecases();
  LogOutBloc() : super(LogOutInitial()) {
    on<LogoutRequestEvent>((event, emit) async {
      emit(LogOutLoadingState());

      try {
        final secureStorage = await SecureStorageHelper.loadUser();
        final accessToken = secureStorage['access_token'];
        final refreshToken = secureStorage['refresh_token'];
        log("accessToken # : $accessToken");
        log('refreshToken # : $refreshToken');
        if (accessToken == null || refreshToken == null) {
          emit(LogOutFailureState(errorMessage: "No tokens found in storage."));
          return; // Early exit if tokens are missing
        }

        await logOutUsecases.logOutCall(accessToken, refreshToken);

        await GoogleSignIn().signOut();
      await SecureStorageHelper.clearUser();

        // await SecureStorageHelper.logStoredTokens();

        // final user = await SecureStorageHelper.loadUser();
        // final accessTokenAfter = user['access_token'];
        // final refreshTokenAfter = user['refresh_token'];
        // log("accessToken after logout # : $accessTokenAfter");
        // log('refreshToken after logout # : $refreshTokenAfter');

        emit(LogOutSuccessState());
      } catch (e) {
        emit(LogOutFailureState(errorMessage: e.toString()));
      }
    });
  }
}
