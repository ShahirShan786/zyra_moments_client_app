import 'package:zyra_momments_app/domain/entities/login_entity.dart';

class ActiveUserModel extends ActiveUser {
  const ActiveUserModel(
      {required super.id,
      required super.firstName,
      required super.lastName,
      required super.email,
      required super.role,
      required super.accessToken,
      required super.refreshToken});

  factory ActiveUserModel.fromJson(
    Map<String, dynamic> json,
    String accessToken,
    String refreshToken,
  ) {
    return ActiveUserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

