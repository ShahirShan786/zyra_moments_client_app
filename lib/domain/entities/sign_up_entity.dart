import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? clientId;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? password;
  final String? profileImage;
  final String? googleId;

  const User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.profileImage,
      this.phone,
      this.clientId,
      this.googleId,
      this.password});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [firstName, lastName, phone, email, password, profileImage, clientId , googleId];
}
