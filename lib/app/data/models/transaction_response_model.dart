class TransactionResponseModel {
  final bool success;
  final List<Payment> payments;

  TransactionResponseModel({required this.success, required this.payments});

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionResponseModel(
      success: json['success'] ?? false,
      payments: json['payments'] != null
          ? List<Payment>.from(json['payments'].map((x) => Payment.fromJson(x)))
          : [],
    );
  }
}

class Payment {
  final String? id;
  final User? userId;
  final String? bookingId;
  final User? receiverId;
  final String? createrType;
  final String? receiverType;
  final String? transactionId;
  final int amount;
  final String? currency;
  final String? status;
  final String? paymentIntentId;
  final String? purpose;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Payment({
    this.id,
    this.userId,
    this.bookingId,
    this.receiverId,
    this.createrType,
    this.receiverType,
    this.transactionId,
    required this.amount,
    this.currency,
    this.status,
    this.paymentIntentId,
    this.purpose,
    this.createdAt,
    this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['_id'],
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      bookingId: json['bookingId'],
      receiverId: json['receiverId'] != null ? User.fromJson(json['receiverId']) : null,
      createrType: json['createrType'],
      receiverType: json['receiverType'],
      transactionId: json['transactionId'],
      amount: _parseToInt(json['amount']),
      currency: json['currency'],
      status: json['status'],
      paymentIntentId: json['paymentIntentId'],
      purpose: json['purpose'],
      createdAt: json['createdAt'] != null ? _parseDateTime(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? _parseDateTime(json['updatedAt']) : null,
    );
  }

  // Helper method to safely convert dynamic values to int
  static int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // Helper method to safely parse DateTime
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    try {
      if (value is String) {
        return DateTime.parse(value);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  // Helper method to get full name
  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    return '$first $last'.trim();
  }

  // Helper method to get display name
  String get displayName {
    if (firstName != null && firstName!.isNotEmpty) {
      return firstName!;
    }
    if (email != null && email!.isNotEmpty) {
      return email!;
    }
    return 'Unknown User';
  }
}

