  import 'dart:developer';

  import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
  import 'package:google_sign_in/google_sign_in.dart';
  import 'package:zyra_momments_app/application/core/api/api_keys.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
  import 'package:zyra_momments_app/data/data_source/sign_up_remote_data_source.dart';
import 'package:zyra_momments_app/domain/entities/login_entity.dart';
  import 'package:zyra_momments_app/domain/entities/sign_up_entity.dart';
  import 'package:zyra_momments_app/domain/repository/sing_up_repository.dart';

  import '../models/user_model.dart';

  class SignInRepositoryImpl implements SingUpRepository {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final SigninRemoteDataSource signinRemoteDataSource =
        SigninRemoteDataSourceImpl();

    @override
    Future<String> register(User user) async {
      try {
        var result = await signinRemoteDataSource.registerUser((UserModel(
            firstName: user.firstName,
            lastName: user.lastName,
            phone: user.phone,
            email: user.email,
            password: user.password)));
        return result;
      } catch (e) {
        throw Exception("$e");
      }
    }

    @override
Future<Either<Failure, ActiveUser>> registerWithGoogle() async {
  try {
    log("Attempting Google Sign-In...");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      log("Google Sign-In canceled by user.");
      return Left(ServerFailure(message: "Google Sign-In cancelled by user"));
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    log("Google Sign-In success. Access Token: ${googleAuth.accessToken}");
    log("Google Sign-In success. Id Token: ${googleAuth.idToken}");

    // Call to remote data source
    final result = await signinRemoteDataSource.registerWithGoogle(
      googleClientId, 
      googleAuth.idToken!,
    );

    // Optional: save user data if needed
    // await SecureStorageHelper.saveUser(...);

    log("Google Sign-In result: $result");
    return result;
  } catch (e) {
    log("Google Sign-In error: $e");
    return Left(ServerFailure(message: "Google Sign-In failed: ${e.toString()}"));
  }
}

  }
