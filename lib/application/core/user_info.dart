import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final storage = FlutterSecureStorage();

  // keys
  static const keyAccessToken = "access_token";
  static const keyRefreshToken = "refresh_token";
  static const keyFirstName = "first_name";
  static const keyLastName = "last_name";
  static const keyEmail = "email";
  static const keyRole = "role";
  static const key_userID = 'id';

  // Save user data
  static Future<void> saveUser({
    required String accessToken,
    required String refreshToken,
    required String firstName,
    required String lastName,
    required String email,
    required String role,
    required String id
  }) async {
    await storage.write(key: keyAccessToken, value: accessToken);
    await storage.write(key: keyRefreshToken, value: refreshToken);
    await storage.write(key: keyFirstName, value: firstName);
    await storage.write(key: keyLastName, value: lastName);
    await storage.write(key: keyEmail, value: email);
    await storage.write(key: keyRole, value: role);
    await storage.write(key: key_userID, value: id);
  }


  // Load data

    static Future<Map<String , String>> loadUser()async{
      final accessToken = await storage.read(key: keyAccessToken);
      final refreshToken = await storage.read(key: keyRefreshToken);
      final firstName = await storage.read(key: keyFirstName);
      final lastName = await storage.read(key: keyLastName);
      final email = await storage.read(key: keyEmail);
      final role = await storage.read(key: keyRole);
      final id = await storage.read(key: key_userID);

      
  if ([accessToken, refreshToken, firstName, lastName, email, role, id].contains(null)) {
    throw Exception("Missing required user data in secure storage");
  }

      return{
        keyAccessToken : accessToken!,
        keyRefreshToken : refreshToken!,
        keyFirstName : firstName!,
        keyLastName : lastName!,
        keyEmail : email!,
        keyRole : role!,
        key_userID : id!,


      };
    }

    static Future<void > clearUser()async{
      await storage.deleteAll();
    }

    static Future<void> clearTokensOnly() async {
  await storage.delete(key: keyAccessToken);
  await storage.delete(key: keyRefreshToken);
}


static Future<void> logStoredTokens() async {
  final accessToken = await storage.read(key: keyAccessToken);
  final refreshToken = await storage.read(key: keyRefreshToken);

  log("accessToken (raw) # : $accessToken");
  log("refreshToken (raw) # : $refreshToken");
}
}
