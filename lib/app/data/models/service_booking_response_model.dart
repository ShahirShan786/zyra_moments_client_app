class BookingResponseModel {
  final bool success;
  final String message;
  final String clientSecret;

  BookingResponseModel({
    required this.success,
    required this.message,
    required this.clientSecret,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      clientSecret: json['clientSecret'] ?? '',
    );
  }
}
