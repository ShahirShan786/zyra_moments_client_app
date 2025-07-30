// booking_request_model.dart
class BookingRequestModel {
  final int amount;
  final BookingDataModel bookingData;
  final String createrType;
  final String purpose;
  final String receiverType;

  BookingRequestModel({
    required this.amount,
    required this.bookingData,
    required this.createrType,
    required this.purpose,
    required this.receiverType,
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "bookingData": bookingData.toJson(),
      "createrType": createrType,
      "purpose": purpose,
      "receiverType": receiverType,
    };
  }
}

class BookingDataModel {
  final String bookingDate;
  final String serviceId;
  final TimeSlotModel timeSlot;
  final String endTime;
  final String startTime;
  final int totalPrice;
  final String vendorId;

  BookingDataModel({
    required this.bookingDate,
    required this.serviceId,
    required this.timeSlot,
    required this.endTime,
    required this.startTime,
    required this.totalPrice,
    required this.vendorId,
  });

  Map<String, dynamic> toJson() {
    return {
      "bookingDate": bookingDate,
      "serviceId": serviceId,
      "timeSlot": timeSlot.toJson(),
      "endTime": endTime,
      "startTime": startTime,
      "totalPrice": totalPrice,
      "vendorId": vendorId,
    };
  }
}

class TimeSlotModel {
  final String startTime;
  final String endTime;

  TimeSlotModel({
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "startTime": startTime,
      "endTime": endTime,
    };
  }
}