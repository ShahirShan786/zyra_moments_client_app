

import 'package:zyra_momments_app/domain/entities/sign_up_entity.dart';

class UserModel extends User {
  const UserModel(
      {required super.firstName,
      required super.lastName,
      required super.email,
      super.phone,
      super.password,
      super.googleId,
      super.profileImage,
      super.clientId
      
    });

      Map<String , dynamic> toJson(){
        return {
          'firstName' : firstName,
          'lastName' : lastName,
          'email' : email,
          'phoneNumber' : phone,
          'password' : password,
          'googleId' : googleId,
          'profileImage' : profileImage,
           'clientId' : clientId,
        };
      }
}
