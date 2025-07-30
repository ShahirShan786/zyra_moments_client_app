import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zyra_momments_app/application/core/user_info.dart';
import 'package:zyra_momments_app/domain/entities/login_entity.dart';
import 'package:zyra_momments_app/domain/usercases/login_usecase.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isPasswordVisible = false;
  final LoginUsecase loginUsecases;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  LoginBloc(this.loginUsecases) : super(LoginInitial()) {
    // Handling login request
    on<LoginRequestEvent>((event, emit) async {
      emit(LoginStateLoading());
      log("Attempting login with email: ${event.email}");

      final result = await loginUsecases.call(event.email, event.password);

      await result.fold(
        (failure) async {
          log("Login failed with error: ${failure.message}");
          
          // Emit specific error states based on failure type
          if (failure is NetworkFailure) {
            emit(LoginStateNetworkError(failure.message));
          } else if (failure is AuthenticationFailure) {
            emit(LoginStateAuthenticationError(failure.message));
          } else if (failure is ValidationFailure) {
            emit(LoginStateValidationError(failure.message));
          } else {
            emit(LoginStateFailure(failure.message));
          }
        },
        (user) async {
          log("Login response: ${user.toString()}");
          log("Login successful, storing tokens...");
          log("AccessToken to be stored: ${user.accessToken}");
          log("RefreshToken to be stored: ${user.refreshToken}");
          log("userId to be stored: ${user.id}");

          try {
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
            
            // Log storage success
            final access = await secureStorage.read(key: 'access_token');
            final refresh = await secureStorage.read(key: 'refresh_token');
            
            log("Stored AccessToken: $access");
            log("Stored RefreshToken: $refresh");

            emit(LoginStateSuccess(user: user));
          } catch (e) {
            log("Error saving tokens to secure storage: $e");
            emit(LoginStateFailure("Failed to save login information. Please try logging in again."));
          }
        },
      );
    });

    // Handling password visibility toggle
    on<TogglePasswordVisibilityEvent>((event, emit) {
      isPasswordVisible = !isPasswordVisible;
      emit(LoginInitial(isPasswordVisible: isPasswordVisible));
    });
  }
}









// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:zyra_momments_app/application/core/user_info.dart';
// import 'package:zyra_momments_app/domain/entities/login_entity.dart';
// import 'package:zyra_momments_app/domain/usercases/login_usecase.dart';


// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   bool isPasswordVisible = false;
//   final LoginUsecase loginUsecases;
//   // final ProfileBloc profileBloc;
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();

//   LoginBloc(this.loginUsecases,) : super(LoginInitial()) {
//     // Handling login request
//     on<LoginRequestEvent>((event, emit) async {
//       emit(LoginStateLoading());
//       log("Attempting login with email: ${event.email}");

//       final result = await loginUsecases.call(event.email, event.password);

//       await result.fold(
//         (failure) async {
//           log("Login failed with error: ${failure.message}");
//           emit(LoginStateFailure(failure.message));
//         },
//         (user) async {
//           log("Login response.....................: ${user.toString()}");
//           log("Login successful, storing tokens...");
//           log("AccessToken to be stored: ${user.accessToken}");
//           log("RefreshToken to be stored: ${user.refreshToken}");
//           log("userId to be stored : ${user.id} ");

//           try {
//             // Save tokens and user info
//             await SecureStorageHelper.saveUser(
//               accessToken: user.accessToken,
//               refreshToken: user.refreshToken,
//               firstName: user.firstName,
//               lastName: user.lastName,
//               email: user.email,
//               role: user.role,
//               id: user.id
//             );
//             // Log storage success
//             final access = await secureStorage.read(key: 'access_token');
//             final refresh = await secureStorage.read(key: 'refresh_token');
            
//             log("Stored AccessToken: $access");
//             log("Stored RefreshToken: $refresh");

//             // profileBloc.add(FetchProfileEvent(user));
//             emit(LoginStateSuccess(user: user));
//           } catch (e) {
//             log("Error saving tokens to secure storage: $e");
//             emit(LoginStateFailure("Storage error"));
//           }
//         },
//       );
//     });

//     // Handling password visibility toggle
//     on<TogglePasswordVisibilityEvent>((event, emit) {
//       isPasswordVisible = !isPasswordVisible;
//       emit(LoginInitial(isPasswordVisible: isPasswordVisible));
//     });
//   }
// }









































































// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:zyra_momments_app/application/core/user_info.dart';
// import 'package:zyra_momments_app/data/models/active_user_model.dart';
// import 'package:zyra_momments_app/domain/usercases/login_usecase.dart';



// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//  bool isPasswordVisible = false;
//   final LoginUsecase loginUsecases;
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();


//   LoginBloc(this.loginUsecases) : super(LoginInitial()){
//    on<LoginRequestEvent>((event, emit) async {
//   emit(LoginStateLoading());

//   final result = await loginUsecases.call(event.email, event.password);

//   // ✅ Wrap everything inside an awaited Future
//   await Future(() async {
//     await result.fold(
//       (failure) async {
//         emit(LoginStateFailure(failure.message));
//       },
//       (user) async {
//         await SecureStorageHelper.saveUser(
//           accessToken: user.accessToken,
//           refreshToken: user.refreshToken,
//           firstName: user.firstName,
//           lastName: user.lastName,
//           email: user.email,
//           role: user.role,
//         );

//         final access = await secureStorage.read(key: 'accessToken');
//         final refresh = await secureStorage.read(key: 'refreshToken');
//         log("accessTokensss : $access");
//         log("refreshTokensss : $refresh");

//         emit(LoginStateSuccess(user: user));
//       },
//     );
//   });
// });


//      on<TogglePasswordVisibilityEvent>((event ,emit){
//       isPasswordVisible = !isPasswordVisible;
//       emit(LoginInitial(isPasswordVisible: isPasswordVisible));
//     });
//   }
// }
