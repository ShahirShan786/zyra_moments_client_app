import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/domain/entities/login_entity.dart';
import 'package:zyra_momments_app/domain/entities/sign_up_entity.dart';
import 'package:zyra_momments_app/domain/repository/sing_up_repository.dart';

part 'auth_sign_event.dart';
part 'auth_sign_state.dart';

class AuthSignBloc extends Bloc<AuthSignEvent, AuthSignState> {
   bool isPasswordVisible = false;
  final SingUpRepository signupRepository;

  String? firstName;
  String? lastName;
  String? phone;
  String? pendingPassword;
  // String? pendingCofirmPassword;
  AuthSignBloc(this.signupRepository) : super(AuthSignInitial()) {
    on<FirstPageSubmitted>((event, emit) {
      firstName = event.firstName;
      lastName = event.lastName;
      phone = event.phone;

      emit(FirstPageSaved(
          firstName: event.firstName,
          lastName: event.lastName,
          phone: event.phone));
    });

    on<RegisterUserEvent>(
      (event, emit) async {
        emit(AuthSignStateLoading());

        if (firstName == null || lastName == null || phone == null) {
          emit(AuthSignStateFailure(
              errorMessage: "First page details are missing!"));
          return;
        }

        final user = User(
            firstName: firstName!,
            lastName: lastName!,
            phone: phone!,
            email: event.email,
            password: event.password);

        final result = await signupRepository.register(user);
        log("the result status is.........   :$result");
        pendingPassword = event.password;
        if (result == "success") {
          emit(AuthSignStateSuccess());
        } else if(result == "email_exists"){
          emit(AuthSignStateFailure(errorMessage: "Email already registered. Try logging in."));
        } else{
          emit(AuthSignStateFailure(errorMessage: "Registration failed. Please try again."));
        }
      },
    );

    on<RegisteWIthGoogleEvent>((event, emit)async {
      emit(AuthSignGoogleStateLoading());

       try{
        
         final result = await signupRepository.registerWithGoogle();
         log("Google Sign-In Bloc Result: $result"); 
        await result.fold((failure){
          emit(AuthSignGoogleStateFailure(errorMessage: failure.message));
         }, (user)async{
           
               log("Login response: ${user.toString()}");
          log("Login successful, storing tokens...");
          log("AccessToken to be stored: ${user.accessToken}");
          log("RefreshToken to be stored: ${user.refreshToken}");
          log("userId to be stored: ${user.id}");

          
            // Save tokens and user info
            await SecureStorageHelper.saveUser(
              accessToken: user.accessToken,
              refreshToken: user.refreshToken,
              firstName: user.firstName,
              lastName: user.lastName,
              email: user.email,
              role: user.role,
              id: user.id
            );
          emit(AuthSignGoogleStateSuccess(user: user));
         });

       }catch(e){
        emit(AuthSignGoogleStateFailure(errorMessage: "Google Sign-In failed: $e"));
       }
    },);

      on<ToggleSignPasswordVisibilityEvent>((event ,emit){
      isPasswordVisible = !isPasswordVisible;
      emit(AuthSignInitial(isPasswordVisible: isPasswordVisible));
    });
  }
}
