class ClientModel {
  final String id;
  final String clientId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  final String phoneNumber;
  final bool masterOfCeremonies;
  final String status;
  final String onlineStatus;
  final DateTime lastStatusUpdated;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Optional fields
  final String? profileImage;
  final String? bio;
  final String? place;

  ClientModel({
    required this.id,
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.phoneNumber,
    required this.masterOfCeremonies,
    required this.status,
    required this.onlineStatus,
    required this.lastStatusUpdated,
    required this.createdAt,
    required this.updatedAt,
    this.profileImage,
    this.bio,
    this.place,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id'] ?? '',
      clientId: json['clientId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      masterOfCeremonies: json['masterOfCeremonies'] ?? false,
      status: json['status'] ?? '',
      onlineStatus: json['onlineStatus'] ?? '',
      lastStatusUpdated: json['lastStatusUpdated'] != null
          ? DateTime.parse(json['lastStatusUpdated'])
          : DateTime.now(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      profileImage: json['profileImage'],
      bio: json['bio'],
      place: json['place'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'clientId': clientId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'role': role,
      'phoneNumber': phoneNumber,
      'masterOfCeremonies': masterOfCeremonies,
      'status': status,
      'onlineStatus': onlineStatus,
      'lastStatusUpdated': lastStatusUpdated.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'profileImage': profileImage,
      'bio': bio,
      'place': place,
    };
  }
}


class UpdateClientRequest {
  final String? firstName;
  final String? lastName;
  final String? place;
  final String? phoneNumber;
  final String? profileImage;

  UpdateClientRequest({
    this.firstName,
    this.lastName,
    this.place,
    this.phoneNumber,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (place != null) 'place': place,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (profileImage != null) 'profileImage': profileImage,
    };
  }
}
