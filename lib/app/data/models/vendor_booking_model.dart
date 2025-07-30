// Make sure your VendorBookingModel.toJson() method generates this structure:

class VendorBookingModel {
  final double amount;
  final String purpose;
  final BookingData bookingData;
  final double totalPrice;
  final String vendorId;
  final String createrType;
  final String receiverType;

  VendorBookingModel({
    required this.amount,
    required this.purpose,
    required this.bookingData,
    required this.totalPrice,
    required this.vendorId,
    required this.createrType,
    required this.receiverType,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'purpose': purpose,
      'bookingData': bookingData.toJson(),  // ❌ This should NOT include totalPrice and vendorId
      'totalPrice': totalPrice,
      'vendorId': vendorId,
      'createrType': createrType,
      'receiverType': receiverType,
    };
  }
}

class BookingData {
  final String bookingDate;
  final String serviceId;
  final TimeSlot timeSlot;

  BookingData({
    required this.bookingDate,
    required this.serviceId,
    required this.timeSlot,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingDate': bookingDate,
      'serviceId': serviceId,
      'timeSlot': timeSlot.toJson(),
      // ❌ REMOVE these if they exist:
      // 'totalPrice': ...,
      // 'vendorId': ...,
    };
  }
}

class TimeSlot {
  final String startTime;
  final String endTime;

  TimeSlot({
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}




// class VendorBookingModel {
//   final int amount;
//   final String purpose;
//   final BookingData bookingData;
//   final int totalPrice;
//   final String vendorId;
//   final String createrType;
//   final String receiverType;

//   VendorBookingModel({
//     required this.amount,
//     required this.purpose,
//     required this.bookingData,
//     required this.totalPrice,
//     required this.vendorId,
//     required this.createrType,
//     required this.receiverType,
//   });

//   factory VendorBookingModel.fromJson(Map<String, dynamic> json) {
//     return VendorBookingModel(
//       amount: json['amount'],
//       purpose: json['purpose'],
//       bookingData: BookingData.fromJson(json['bookingData']),
//       totalPrice: json['totalPrice'],
//       vendorId: json['vendorId'],
//       createrType: json['createrType'],
//       receiverType: json['receiverType'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'amount': amount,
//       'purpose': purpose,
//       'bookingData': bookingData.toJson(),
//       'totalPrice': totalPrice,
//       'vendorId': vendorId,
//       'createrType': createrType,
//       'receiverType': receiverType,
//     };
//   }
// }

// class BookingData {
//   final String bookingDate;
//   final String serviceId;
//   final TimeSlot timeSlot;

//   BookingData({
//     required this.bookingDate,
//     required this.serviceId,
//     required this.timeSlot,
//   });

//   factory BookingData.fromJson(Map<String, dynamic> json) {
//     return BookingData(
//       bookingDate: json['bookingDate'],
//       serviceId: json['serviceId'],
//       timeSlot: TimeSlot.fromJson(json['timeSlot']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'bookingDate': bookingDate,
//       'serviceId': serviceId,
//       'timeSlot': timeSlot.toJson(),
//     };
//   }
// }

// class TimeSlot {
//   final String startTime;
//   final String endTime;

//   TimeSlot({
//     required this.startTime,
//     required this.endTime,
//   });

//   factory TimeSlot.fromJson(Map<String, dynamic> json) {
//     return TimeSlot(
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'startTime': startTime,
//       'endTime': endTime,
//     };
//   }
// }
