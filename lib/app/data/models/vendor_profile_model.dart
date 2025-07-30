import 'dart:developer';

import 'package:intl/intl.dart';

class VendorProfileModel {
  final bool success;
  final VendorData? vendorData;
  final int currentServicePage;
  final int totalServicePages;
  final int currentWorkSamplePage;
  final int totalWorkSamplePage;

  VendorProfileModel({
    required this.success,
    required this.vendorData,
    required this.currentServicePage,
    required this.totalServicePages,
    required this.currentWorkSamplePage,
    required this.totalWorkSamplePage,
  });

  factory VendorProfileModel.fromJson(Map<String, dynamic> json) {
    return VendorProfileModel(
      success: json['success'] ?? false,
      vendorData: json['vendorData'] != null
          ? VendorData.fromJson(json['vendorData'])
          : null,
      currentServicePage: json['currentServicePage'] ?? 0,
      totalServicePages: json['totalServicePages'] ?? 0,
      currentWorkSamplePage: json['currentWorkSamplePage'] ?? 0,
      totalWorkSamplePage: json['totalWorkSamplePage'] ?? 0,
    );
  }
}

class VendorData {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String status;
  final bool canChat;
  final String vendorId;
  final Category? category;
  final List<WorkSample> workSamples;
  final List<Service> services;

  VendorData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.status,
    required this.canChat,
    required this.vendorId,
    required this.category,
    required this.workSamples,
    required this.services,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) {
    return VendorData(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      status: json['status'] ?? '',
      canChat: json['canChat'] ?? false,
      vendorId: json['vendorId'] ?? '',
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      workSamples: (json['workSamples'] as List? ?? [])
          .map((e) => WorkSample.fromJson(e))
          .toList(),
      services: (json['services'] as List? ?? [])
          .map((e) => Service.fromJson(e))
          .toList(),
    );
  }
}

class Category {
  final String id;
  final String title;

  Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class WorkSample {
  final String id;
  final String title;
  final String description;
  final List<String> images;

  WorkSample({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
  });

  factory WorkSample.fromJson(Map<String, dynamic> json) {
    return WorkSample(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }
}

class Service {
  final String id;
  final String vendorId;
  final String serviceTitle;
  final int yearsOfExperience;
  final List<AvailableDate> availableDates;
  final String serviceDescription;
  final int serviceDuration;
  final int servicePrice;
  final int additionalHoursPrice;
  final List<String> cancellationPolicies;
  final List<String> termsAndConditions;

  Service({
    required this.id,
    required this.vendorId,
    required this.serviceTitle,
    required this.yearsOfExperience,
    required this.availableDates,
    required this.serviceDescription,
    required this.serviceDuration,
    required this.servicePrice,
    required this.additionalHoursPrice,
    required this.cancellationPolicies,
    required this.termsAndConditions,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    log('AvailableDates raw data: ${json['availableDates']}');
    return Service(
      id: json['_id'] ?? '',
      vendorId: json['vendorId'] ?? '',
      serviceTitle: json['serviceTitle'] ?? '',
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      availableDates: (json['availableDates'] as List? ?? [])
          .map((e) => AvailableDate.fromJson(e))
          .toList(),
      serviceDescription: json['serviceDescription'] ?? '',
      serviceDuration: json['serviceDuration'] ?? 0,
      servicePrice: json['servicePrice'] ?? 0,
      additionalHoursPrice: json['additionalHoursPrice'] ?? 0,
      cancellationPolicies:
          List<String>.from(json['cancellationPolicies'] ?? []),
      termsAndConditions: List<String>.from(json['termsAndConditions'] ?? []),
    );
  }
}

class AvailableDate {
  final DateTime date;
  final List<TimeSlot> timeSlots;
  final String id;

  AvailableDate({
    required this.date,
    required this.timeSlots,
    required this.id,
  });

  factory AvailableDate.fromJson(Map<String, dynamic> json) {
    final rawDate = json['date'] ?? '';
    DateTime? parsedDate;

    if (rawDate.isNotEmpty) {
      try {
        final parts = rawDate.split('-');
        if (parts.length == 3) {
          // Parse in yyyy-MM-dd format
          parsedDate = DateTime(
            int.parse(parts[0]), // year (first part)
            int.parse(parts[1]), // month (second part)
            int.parse(parts[2]), // day (third part)
          );
          log('Successfully parsed date: $rawDate → ${parsedDate.toIso8601String()}');
        } else {
          log('Invalid date format: $rawDate - expected yyyy-MM-dd');
        }
      } catch (e) {
        log('Error parsing date: $rawDate — $e');
      }
    } else {
      log('Error: Empty or null date in JSON.');
    }

    return AvailableDate(
      date: parsedDate ?? DateTime.now().add(const Duration(days: 1)),
      timeSlots: (json['timeSlots'] as List? ?? [])
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
      id: json['_id'] ?? '',
    );
  }

  // Helper method to format the date for display
  String formatDate() {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}

class TimeSlot {
  final String startTime;
  final String endTime;
  final int capacity;
  final int count;
  final String id;

  TimeSlot({
    required this.startTime,
    required this.endTime,
    required this.capacity,
    required this.count,
    required this.id,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      capacity: json['capacity'] ?? 0,
      count: json['count'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
}









// import 'dart:developer';

// class VendorProfileModel {
//   final bool success;
//   final VendorData? vendorData;
//   final int currentServicePage;
//   final int totalServicePages;
//   final int currentWorkSamplePage;
//   final int totalWorkSamplePage;

//   VendorProfileModel({
//     required this.success,
//     required this.vendorData,
//     required this.currentServicePage,
//     required this.totalServicePages,
//     required this.currentWorkSamplePage,
//     required this.totalWorkSamplePage,
//   });

//   factory VendorProfileModel.fromJson(Map<String, dynamic> json) {
//     return VendorProfileModel(
//       success: json['success'] ?? false,
//       vendorData: json['vendorData'] != null
//           ? VendorData.fromJson(json['vendorData'])
//           : null,
//       currentServicePage: json['currentServicePage'] ?? 0,
//       totalServicePages: json['totalServicePages'] ?? 0,
//       currentWorkSamplePage: json['currentWorkSamplePage'] ?? 0,
//       totalWorkSamplePage: json['totalWorkSamplePage'] ?? 0,
//     );
//   }
// }

// class VendorData {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final String status;
//   final bool canChat;
//   final String vendorId;
//   final Category? category;
//   final List<WorkSample> workSamples;
//   final List<Service> services;

//   VendorData({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phoneNumber,
//     required this.status,
//     required this.canChat,
//     required this.vendorId,
//     required this.category,
//     required this.workSamples,
//     required this.services,
//   });

//   factory VendorData.fromJson(Map<String, dynamic> json) {
//     return VendorData(
//       id: json['_id'] ?? '',
//       firstName: json['firstName'] ?? '',
//       lastName: json['lastName'] ?? '',
//       email: json['email'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//       status: json['status'] ?? '',
//       canChat: json['canChat'] ?? false,
//       vendorId: json['vendorId'] ?? '',
//       category:
//           json['category'] != null ? Category.fromJson(json['category']) : null,
//       workSamples: (json['workSamples'] as List? ?? [])
//           .map((e) => WorkSample.fromJson(e))
//           .toList(),
//       services: (json['services'] as List? ?? [])
//           .map((e) => Service.fromJson(e))
//           .toList(),
//     );
//   }
// }

// class Category {
//   final String id;
//   final String title;

//   Category({
//     required this.id,
//     required this.title,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//     );
//   }
// }

// class WorkSample {
//   final String id;
//   final String title;
//   final String description;
//   final List<String> images;

//   WorkSample({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.images,
//   });

//   factory WorkSample.fromJson(Map<String, dynamic> json) {
//     return WorkSample(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       images: List<String>.from(json['images'] ?? []),
//     );
//   }
// }

// class Service {
//   final String id;
//   final String vendorId;
//   final String serviceTitle;
//   final int yearsOfExperience;
//   final List<AvailableDate> availableDates;
//   final String serviceDescription;
//   final int serviceDuration;
//   final int servicePrice;
//   final int additionalHoursPrice;
//   final List<String> cancellationPolicies;
//   final List<String> termsAndConditions;

//   Service({
//     required this.id,
//     required this.vendorId,
//     required this.serviceTitle,
//     required this.yearsOfExperience,
//     required this.availableDates,
//     required this.serviceDescription,
//     required this.serviceDuration,
//     required this.servicePrice,
//     required this.additionalHoursPrice,
//     required this.cancellationPolicies,
//     required this.termsAndConditions,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) {
//     log('AvailableDates raw data: ${json['availableDates']}');
//     return Service(
//       id: json['_id'] ?? '',
//       vendorId: json['vendorId'] ?? '',
//       serviceTitle: json['serviceTitle'] ?? '',
//       yearsOfExperience: json['yearsOfExperience'] ?? 0,
//       availableDates: (json['availableDates'] as List? ?? [])
//           .map((e) => AvailableDate.fromJson(e))
//           .toList(),
//       serviceDescription: json['serviceDescription'] ?? '',
//       serviceDuration: json['serviceDuration'] ?? 0,
//       servicePrice: json['servicePrice'] ?? 0,
//       additionalHoursPrice: json['additionalHoursPrice'] ?? 0,
//       cancellationPolicies:
//           List<String>.from(json['cancellationPolicies'] ?? []),
//       termsAndConditions: List<String>.from(json['termsAndConditions'] ?? []),
//     );
//   }
// }

// class AvailableDate {
//   final DateTime date;
//   final List<TimeSlot> timeSlots;
//   final String id;

//   AvailableDate({
//     required this.date,
//     required this.timeSlots,
//     required this.id,
//   });

//   factory AvailableDate.fromJson(Map<String, dynamic> json) {
//     final rawDate = json['date'] ?? '';
//     DateTime? parsedDate;

//     if (rawDate.isNotEmpty) {
//       try {
//         final parts = rawDate.split('-');
//         if (parts.length == 3) {
//           // Parse in dd-MM-yyyy format
//           parsedDate = DateTime(
//             int.parse(parts[2]), // year (third part)
//             int.parse(parts[1]), // month (second part)
//             int.parse(parts[0]), // day (first part)
//           );
//           log('Successfully parsed date: $rawDate → ${parsedDate.toIso8601String()}');
//         } else {
//           log('Invalid date format: $rawDate - expected dd-MM-yyyy');
//         }
//       } catch (e) {
//         log('Error parsing date: $rawDate — $e');
//       }
//     } else {
//       log('Error: Empty or null date in JSON.');
//     }

//     return AvailableDate(
//       date: parsedDate ?? DateTime.now().add(const Duration(days: 1)),
//       timeSlots: (json['timeSlots'] as List? ?? [])
//           .map((e) => TimeSlot.fromJson(e))
//           .toList(),
//       id: json['_id'] ?? '',
//     );
//   }
// }

// // class AvailableDate {
// //   final DateTime date;
// //   final List<TimeSlot> timeSlots;
// //   final String id;

// //   AvailableDate({
// //     required this.date,
// //     required this.timeSlots,
// //     required this.id,
// //   });

// //   factory AvailableDate.fromJson(Map<String, dynamic> json) {
// //     final rawDate = json['date'] ?? '';
// //     DateTime? parsedDate;

// //     if (rawDate.isNotEmpty) {
// //       try {
// //         final parts = rawDate.split('-');
// //         parsedDate = DateTime(
// //           int.parse(parts[0]),
// //           int.parse(parts[1]),
// //           int.parse(parts[2]),
// //         );
// //         log('Parsing date: $rawDate → $parsedDate');
// //       } catch (e) {
// //         log('Error parsing date: $rawDate — $e');
// //       }
// //     } else {
// //       log('Error: Empty or null date in JSON.');
// //     }

// //     return AvailableDate(
// //       date: parsedDate ?? DateTime.now().add(const Duration(days: 1)),
// //       timeSlots: (json['timeSlots'] as List? ?? [])
// //           .map((e) => TimeSlot.fromJson(e))
// //           .toList(),
// //       id: json['_id'] ?? '',
// //     );
// //   }
// // }

// class TimeSlot {
//   final String startTime;
//   final String endTime;
//   final int capacity;
//   final int count;
//   final String id;

//   TimeSlot({
//     required this.startTime,
//     required this.endTime,
//     required this.capacity,
//     required this.count,
//     required this.id,
//   });

//   factory TimeSlot.fromJson(Map<String, dynamic> json) {
//     return TimeSlot(
//       startTime: json['startTime'] ?? '',
//       endTime: json['endTime'] ?? '',
//       capacity: json['capacity'] ?? 0,
//       count: json['count'] ?? 0,
//       id: json['_id'] ?? '',
//     );
//   }
// }
