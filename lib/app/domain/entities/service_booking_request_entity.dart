class BookingRequest {
  final int amount;
  final BookingData bookingData;
  final String createrType;
  final String purpose;
  final String receiverType;

  BookingRequest({
    required this.amount,
    required this.bookingData,
    required this.createrType,
    required this.purpose,
    required this.receiverType,
  });
}

class BookingData {
  final String bookingDate;
  final String serviceId;
  final TimeSlot timeSlot;
  final String endTime;
  final String startTime;
  final int totalPrice;
  final String vendorId;

  BookingData({
    required this.bookingDate,
    required this.serviceId,
    required this.timeSlot,
    required this.endTime,
    required this.startTime,
    required this.totalPrice,
    required this.vendorId,
  });
}

class TimeSlot {
  final String startTime;
  final String endTime;

  TimeSlot({
    required this.startTime,
    required this.endTime,
  });
}
