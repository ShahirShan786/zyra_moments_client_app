class WalletResponseModel {
  final bool success;
  final WalletData? walletData;

  WalletResponseModel({
    required this.success,
    this.walletData,
  });

  factory WalletResponseModel.fromJson(Map<String, dynamic> json) {
    return WalletResponseModel(
      success: json['success'] ?? false,
      walletData: json['walletData'] != null
          ? WalletData.fromJson(json['walletData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'walletData': walletData?.toJson(),
      };
}

class WalletData {
  final String? id;
  final UserId? userId;
  final String? userType;
  final String? role;
  final int balance;
  final List<Payment> paymentId;
  final String? createdAt;
  final String? updatedAt;
  final int v;

  WalletData({
    this.id,
    this.userId,
    this.userType,
    this.role,
    required this.balance,
    required this.paymentId,
    this.createdAt,
    this.updatedAt,
    required this.v,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
      id: json['_id'],
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      userType: json['userType'],
      role: json['role'],
      // Safe conversion from dynamic to int
      balance: _parseToInt(json['balance']),
      paymentId: json['paymentId'] != null
          ? List<Payment>.from(
              json['paymentId'].map((x) => Payment.fromJson(x)))
          : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      // Safe conversion from dynamic to int
      v: _parseToInt(json['__v']),
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

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId?.toJson(),
        'userType': userType,
        'role': role,
        'balance': balance,
        'paymentId': paymentId.map((x) => x.toJson()).toList(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}

class UserId {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
}

class Payment {
  final String? id;
  final String? userId;
  final String? bookingId;
  final String? receiverId;
  final String? createrType;
  final String? receiverType; 
  final String? transactionId;
  final int amount;
  final String? currency;
  final String? status;
  final String? paymentIntentId;
  final String? purpose;
  final String? createdAt;
  final String? updatedAt;
  final int v;

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
    required this.v,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['_id'],
      userId: json['userId'],
      bookingId: json['bookingId'],
      receiverId: json['receiverId'],
      createrType: json['createrType'],
      receiverType: json['receiverType'],
      transactionId: json['transactionId'],
      // Safe conversion from dynamic to int
      amount: _parseToInt(json['amount']),
      currency: json['currency'],
      status: json['status'],
      paymentIntentId: json['paymentIntentId'],
      purpose: json['purpose'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      // Safe conversion from dynamic to int
      v: _parseToInt(json['__v']),
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

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId,
        'bookingId': bookingId,
        'receiverId': receiverId,
        'createrType': createrType,
        'receiverType': receiverType,
        'transactionId': transactionId,
        'amount': amount,
        'currency': currency,
        'status': status,
        'paymentIntentId': paymentIntentId,
        'purpose': purpose,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}


