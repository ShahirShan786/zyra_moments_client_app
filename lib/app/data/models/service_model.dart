class ServiceModel {
  final bool success;
  final List<Booking> bookings;
  final int totalPages;
  final int currentPage;

  ServiceModel({
    required this.success,
    required this.bookings,
    required this.totalPages,
    required this.currentPage,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      success: json['success'],
      bookings: (json['bookings'] as List)
          .map((e) => Booking.fromJson(e))
          .toList(),
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }
}

class Booking {
  final ServiceDetails serviceDetails;
  final TimeSlot timeSlot;
  final String id;
  final RId userId;
  final RId vendorId;
  final bool isClientApproved;
  final bool isVendorApproved;
  final DateTime bookingDate;
  final double totalPrice; // Changed from int to double
  final String paymentStatus;
  final String status;
  final DateTime createdAt;
  final int v;
  final String paymentId;

  Booking({
    required this.serviceDetails,
    required this.timeSlot,
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.isClientApproved,
    required this.isVendorApproved,
    required this.bookingDate,
    required this.totalPrice,
    required this.paymentStatus,
    required this.status,
    required this.createdAt,
    required this.v,
    required this.paymentId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      serviceDetails: ServiceDetails.fromJson(json['serviceDetails']),
      timeSlot: TimeSlot.fromJson(json['timeSlot']),
      id: json['_id'],
      userId: RId.fromJson(json['userId']),
      vendorId: RId.fromJson(json['vendorId']),
      isClientApproved: json['isClientApproved'],
      isVendorApproved: json['isVendorApproved'],
      bookingDate: DateTime.parse(json['bookingDate']),
      totalPrice: (json['totalPrice'] is int) 
          ? (json['totalPrice'] as int).toDouble() 
          : json['totalPrice'].toDouble(), // Safe conversion
      paymentStatus: json['paymentStatus'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      v: json['__v'],
      paymentId: json['paymentId'],
    );
  }
}

class ServiceDetails {
  final String serviceTitle;
  final String serviceDescription;
  final int serviceDuration;
  final double servicePrice; // Changed from int to double
  final double additionalHoursPrice; // Changed from int to double
  final List<String> cancellationPolicies;
  final List<String> termsAndConditions;

  ServiceDetails({
    required this.serviceTitle,
    required this.serviceDescription,
    required this.serviceDuration,
    required this.servicePrice,
    required this.additionalHoursPrice,
    required this.cancellationPolicies,
    required this.termsAndConditions,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      serviceTitle: json['serviceTitle'],
      serviceDescription: json['serviceDescription'],
      serviceDuration: json['serviceDuration'],
      servicePrice: (json['servicePrice'] is int) 
          ? (json['servicePrice'] as int).toDouble() 
          : json['servicePrice'].toDouble(), // Safe conversion
      additionalHoursPrice: (json['additionalHoursPrice'] is int) 
          ? (json['additionalHoursPrice'] as int).toDouble() 
          : json['additionalHoursPrice'].toDouble(), // Safe conversion
      cancellationPolicies:
          List<String>.from(json['cancellationPolicies'] ?? []),
      termsAndConditions:
          List<String>.from(json['termsAndConditions'] ?? []),
    );
  }
}

class TimeSlot {
  final String startTime;
  final String endTime;

  TimeSlot({
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}

class RId {
  final String id;
  final String firstName;
  final String lastName;

  RId({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory RId.fromJson(Map<String, dynamic> json) {
    return RId(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}




// class ServiceModel {
//   final bool success;
//   final List<Booking> bookings;
//   final int totalPages;
//   final int currentPage;

//   ServiceModel({
//     required this.success,
//     required this.bookings,
//     required this.totalPages,
//     required this.currentPage,
//   });

//   factory ServiceModel.fromJson(Map<String, dynamic> json) {
//     return ServiceModel(
//       success: json['success'],
//       bookings: (json['bookings'] as List)
//           .map((e) => Booking.fromJson(e))
//           .toList(),
//       totalPages: json['totalPages'],
//       currentPage: json['currentPage'],
//     );
//   }
// }

// class Booking {
//   final ServiceDetails serviceDetails;
//   final TimeSlot timeSlot;
//   final String id;
//   final RId userId;
//   final RId vendorId;
//   final bool isClientApproved;
//   final bool isVendorApproved;
//   final DateTime bookingDate;
//   final int totalPrice;
//   final String paymentStatus;
//   final String status;
//   final DateTime createdAt;
//   final int v;
//   final String paymentId;

//   Booking({
//     required this.serviceDetails,
//     required this.timeSlot,
//     required this.id,
//     required this.userId,
//     required this.vendorId,
//     required this.isClientApproved,
//     required this.isVendorApproved,
//     required this.bookingDate,
//     required this.totalPrice,
//     required this.paymentStatus,
//     required this.status,
//     required this.createdAt,
//     required this.v,
//     required this.paymentId,
//   });

//   factory Booking.fromJson(Map<String, dynamic> json) {
//     return Booking(
//       serviceDetails: ServiceDetails.fromJson(json['serviceDetails']),
//       timeSlot: TimeSlot.fromJson(json['timeSlot']),
//       id: json['_id'],
//       userId: RId.fromJson(json['userId']),
//       vendorId: RId.fromJson(json['vendorId']),
//       isClientApproved: json['isClientApproved'],
//       isVendorApproved: json['isVendorApproved'],
//       bookingDate: DateTime.parse(json['bookingDate']),
//       totalPrice: json['totalPrice'],
//       paymentStatus: json['paymentStatus'],
//       status: json['status'],
//       createdAt: DateTime.parse(json['createdAt']),
//       v: json['__v'],
//       paymentId: json['paymentId'],
//     );
//   }
// }

// class ServiceDetails {
//   final String serviceTitle;
//   final String serviceDescription;
//   final int serviceDuration;
//   final int servicePrice;
//   final int additionalHoursPrice;
//   final List<String> cancellationPolicies;
//   final List<String> termsAndConditions;

//   ServiceDetails({
//     required this.serviceTitle,
//     required this.serviceDescription,
//     required this.serviceDuration,
//     required this.servicePrice,
//     required this.additionalHoursPrice,
//     required this.cancellationPolicies,
//     required this.termsAndConditions,
//   });

//   factory ServiceDetails.fromJson(Map<String, dynamic> json) {
//     return ServiceDetails(
//       serviceTitle: json['serviceTitle'],
//       serviceDescription: json['serviceDescription'],
//       serviceDuration: json['serviceDuration'],
//       servicePrice: json['servicePrice'],
//       additionalHoursPrice: json['additionalHoursPrice'],
//       cancellationPolicies:
//           List<String>.from(json['cancellationPolicies'] ?? []),
//       termsAndConditions:
//           List<String>.from(json['termsAndConditions'] ?? []),
//     );
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
// }

// class RId {
//   final String id;
//   final String firstName;
//   final String lastName;

//   RId({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//   });

//   factory RId.fromJson(Map<String, dynamic> json) {
//     return RId(
//       id: json['_id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//     );
//   }
// }
