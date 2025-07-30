import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async{
      
      final user = await SecureStorageHelper.loadUser();

       final accessToken = user['access_token'];
       final refreshToken = user["refresh_token"];

       log("AccessToken is :$accessToken");
       log("refreshToken is :$refreshToken");

       if(accessToken != null && refreshToken != null){
         emit(SplashAuthenticated());
       }else{
        emit(SplashUnAuthenticated());
       }
    });
  }
}
