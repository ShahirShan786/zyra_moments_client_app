class VendorModel {
  final bool success;
  final VendorData? vendorData;
  final int currentServicePage;
  final int totalServicePages;
  final int currentWorkSamplePage;
  final int totalWorkSamplePage;

  VendorModel({
    required this.success,
    this.vendorData,
    required this.currentServicePage,
    required this.totalServicePages,
    required this.currentWorkSamplePage,
    required this.totalWorkSamplePage,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      success: json['success'] ?? false,
      vendorData: json['vendorData'] != null 
          ? VendorData.fromJson(json['vendorData']) 
          : null,
      currentServicePage: json['currentServicePage'] ?? 1,
      totalServicePages: json['totalServicePages'] ?? 1,
      currentWorkSamplePage: json['currentWorkSamplePage'] ?? 1,
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
    this.category,
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
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      workSamples: json['workSamples'] != null 
          ? (json['workSamples'] as List).map((e) => WorkSample.fromJson(e)).toList()
          : [],
      services: json['services'] != null
          ? (json['services'] as List).map((e) => Service.fromJson(e)).toList()
          : [],
    );
  }
}

// Add the WorkSample class that was missing
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
      title: json['title'] ?? 'Elegant Wedding Moments', // Default title if not provided
      description: json['description'] ?? '',
      images: json['images'] != null 
          ? List<String>.from(json['images'])
          : [],
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
    return Service(
      id: json['_id'] ?? '',
      vendorId: json['vendorId'] ?? '',
      serviceTitle: json['serviceTitle'] ?? '',
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      availableDates: json['availableDates'] != null
          ? (json['availableDates'] as List).map((e) => AvailableDate.fromJson(e)).toList()
          : [],
      serviceDescription: json['serviceDescription'] ?? '',
      serviceDuration: json['serviceDuration'] ?? 0,
      servicePrice: json['servicePrice'] ?? 0,
      additionalHoursPrice: json['additionalHoursPrice'] ?? 0,
      cancellationPolicies: json['cancellationPolicies'] != null
          ? List<String>.from(json['cancellationPolicies'])
          : [],
      termsAndConditions: json['termsAndConditions'] != null
          ? List<String>.from(json['termsAndConditions'])
          : [],
    );
  }
}

class AvailableDate {
  final String date;
  final String id;
  final List<TimeSlot> timeSlots;

  AvailableDate({
    required this.date,
    required this.id,
    required this.timeSlots,
  });

  factory AvailableDate.fromJson(Map<String, dynamic> json) {
    return AvailableDate(
      date: json['date'] ?? '',
      id: json['_id'] ?? '',
      timeSlots: json['timeSlots'] != null
          ? (json['timeSlots'] as List).map((e) => TimeSlot.fromJson(e)).toList()
          : [],
    );
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









// class VendorModel {
//   final bool success;
//   final VendorData vendorData;
//   final int currentServicePage;
//   final int totalServicePages;
//   final int currentWorkSamplePage;
//   final int totalWorkSamplePage;

//   VendorModel({
//     required this.success,
//     required this.vendorData,
//     required this.currentServicePage,
//     required this.totalServicePages,
//     required this.currentWorkSamplePage,
//     required this.totalWorkSamplePage,
//   });

//   factory VendorModel.fromJson(Map<String, dynamic> json) {
//     return VendorModel(
//       success: json['success'],
//       vendorData: VendorData.fromJson(json['vendorData']),
//       currentServicePage: json['currentServicePage'],
//       totalServicePages: json['totalServicePages'],
//       currentWorkSamplePage: json['currentWorkSamplePage'],
//       totalWorkSamplePage: json['totalWorkSamplePage'],
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
//   final Category category;
//   final List<dynamic> workSamples;
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
//       id: json['_id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       status: json['status'],
//       canChat: json['canChat'],
//       vendorId: json['vendorId'],
//       category: Category.fromJson(json['category']),
//       workSamples: json['workSamples'],
//       services: (json['services'] as List)
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
//       id: json['_id'],
//       title: json['title'],
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
//     return Service(
//       id: json['_id'],
//       vendorId: json['vendorId'],
//       serviceTitle: json['serviceTitle'],
//       yearsOfExperience: json['yearsOfExperience'],
//       availableDates: (json['availableDates'] as List)
//           .map((e) => AvailableDate.fromJson(e))
//           .toList(),
//       serviceDescription: json['serviceDescription'],
//       serviceDuration: json['serviceDuration'],
//       servicePrice: json['servicePrice'],
//       additionalHoursPrice: json['additionalHoursPrice'],
//       cancellationPolicies:
//           List<String>.from(json['cancellationPolicies']),
//       termsAndConditions:
//           List<String>.from(json['termsAndConditions']),
//     );
//   }
// }

// class AvailableDate {
//   final String date;
//   final String id;
//   final List<TimeSlot> timeSlots;

//   AvailableDate({
//     required this.date,
//     required this.id,
//     required this.timeSlots,
//   });

//   factory AvailableDate.fromJson(Map<String, dynamic> json) {
//     return AvailableDate(
//       date: json['date'],
//       id: json['_id'],
//       timeSlots: (json['timeSlots'] as List)
//           .map((e) => TimeSlot.fromJson(e))
//           .toList(),
//     );
//   }
// }

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
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//       capacity: json['capacity'],
//       count: json['count'],
//       id: json['_id'],
//     );
//   }
// }
