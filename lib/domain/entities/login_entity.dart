import 'package:equatable/equatable.dart';

class ActiveUser extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String accessToken;
  final String refreshToken;

  const ActiveUser(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.role,
      required this.accessToken,
      required this.refreshToken});

      @override
      List<Object> get props =>[id, firstName , lastName ,email, role ,accessToken , refreshToken];
}
