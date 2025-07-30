// service_booking_event.dart
part of 'service_booking_bloc.dart';

sealed class ServiceBookingEvent extends Equatable {
  const ServiceBookingEvent();

  @override
  List<Object?> get props => [];
}

class ServiceSelected extends ServiceBookingEvent {
  final String selectedServiceId;
  final String vendorId;
  final int totalAmount;

  const ServiceSelected({
    required this.selectedServiceId,
    required this.vendorId,
    required this.totalAmount,
  });

  @override
  List<Object> get props => [selectedServiceId, vendorId, totalAmount];
}

class DateSelected extends ServiceBookingEvent {
  final DateTime? selectedDate;

  const DateSelected({this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];
}

class TimeSlotSelected extends ServiceBookingEvent {
  final String selectedTimeSlot;

  const TimeSlotSelected({required this.selectedTimeSlot});

  @override
  List<Object> get props => [selectedTimeSlot];
}

class ZipCodeUpdated extends ServiceBookingEvent {
  final String zipCode;

  const ZipCodeUpdated({required this.zipCode});

  @override
  List<Object> get props => [zipCode];
}

class CardDetailsUpdated extends ServiceBookingEvent {
  final String? cardNumber;
  final int? expiryMonth;
  final int? expiryYear;
  final String? cvc;

  const CardDetailsUpdated({
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.cvc,
  });

  @override
  List<Object?> get props => [cardNumber, expiryMonth, expiryYear, cvc];
}

class ContactNumberUpdated extends ServiceBookingEvent {
  final String contactNumber;

  const ContactNumberUpdated({required this.contactNumber});

  @override
  List<Object> get props => [contactNumber];
}

class EmailUpdated extends ServiceBookingEvent {
  final String email;

  const EmailUpdated({required this.email});

  @override
  List<Object> get props => [email];
}

class ValidateForm extends ServiceBookingEvent {
  final DateTime? selectedDate;
  final String? selectedTimeSlot;

  const ValidateForm({
    this.selectedDate,
    this.selectedTimeSlot,
  });

  @override
  List<Object?> get props => [selectedDate, selectedTimeSlot];
}

// Add this missing event
class ConfirmPaymentForService extends ServiceBookingEvent {
  final VendorBookingModel vendorBookingData;

  const ConfirmPaymentForService({required this.vendorBookingData});

  @override
  List<Object> get props => [vendorBookingData];
}


// Add this event to your service_booking_event.dart

class ResetFormEvent extends ServiceBookingEvent {
  const ResetFormEvent();
  
  @override
  List<Object?> get props => [];
}











// // service_booking_event.dart
// part of 'service_booking_bloc.dart';

// sealed class ServiceBookingEvent extends Equatable {
//   const ServiceBookingEvent();

//   @override
//   List<Object?> get props => [];
// }

// class ServiceSelected extends ServiceBookingEvent {
//   final String selectedServiceId;
//   final String vendorId;
//   final int totalAmount;

//   const ServiceSelected({
//     required this.selectedServiceId,
//     required this.vendorId,
//     required this.totalAmount,
//   });

//   @override
//   List<Object> get props => [selectedServiceId, vendorId, totalAmount];
// }

// class DateSelected extends ServiceBookingEvent {
//   final DateTime? selectedDate;

//   const DateSelected({this.selectedDate});

//   @override
//   List<Object?> get props => [selectedDate];
// }

// class TimeSlotSelected extends ServiceBookingEvent {
//   final String selectedTimeSlot;

//   const TimeSlotSelected({required this.selectedTimeSlot});

//   @override
//   List<Object> get props => [selectedTimeSlot];
// }

// class ZipCodeUpdated extends ServiceBookingEvent {
//   final String zipCode;

//   const ZipCodeUpdated({required this.zipCode});

//   @override
//   List<Object> get props => [zipCode];
// }

// class CardDetailsUpdated extends ServiceBookingEvent {
//   final String? cardNumber;
//   final int? expiryMonth;
//   final int? expiryYear;
//   final String? cvc;

//   const CardDetailsUpdated({
//     this.cardNumber,
//     this.expiryMonth,
//     this.expiryYear,
//     this.cvc,
//   });

//   @override
//   List<Object?> get props => [cardNumber, expiryMonth, expiryYear, cvc];
// }

// class ContactNumberUpdated extends ServiceBookingEvent {
//   final String contactNumber;

//   const ContactNumberUpdated({required this.contactNumber});

//   @override
//   List<Object> get props => [contactNumber];
// }

// class EmailUpdated extends ServiceBookingEvent {
//   final String email;

//   const EmailUpdated({required this.email});

//   @override
//   List<Object> get props => [email];
// }

// class ValidateForm extends ServiceBookingEvent {
//   final DateTime? selectedDate;
//   final String? selectedTimeSlot;

//   const ValidateForm({
//     this.selectedDate,
//     this.selectedTimeSlot,
//   });

//   @override
//   List<Object?> get props => [selectedDate, selectedTimeSlot];
// }

// class ConfirmPaymentForService extends ServiceBookingEvent {
 
//   final VendorBookingModel vendorBookingData;

//   const ConfirmPaymentForService({
    
//     required this.vendorBookingData,
//   });

//   @override
//   List<Object> get props => [vendorBookingData];
// }






// // service_booking_event.dart
// part of 'service_booking_bloc.dart';

// sealed class ServiceBookingEvent extends Equatable {
//   const ServiceBookingEvent();

//   @override
//   List<Object?> get props => [];
// }

// class ServiceSelected extends ServiceBookingEvent {
//   final String selectedServiceId;
//   final String vendorId;
//   final int totalAmount;

//   const ServiceSelected({
//     required this.selectedServiceId,
//     required this.vendorId,
//     required this.totalAmount,
//   });

//   @override
//   List<Object> get props => [selectedServiceId, vendorId, totalAmount];
// }

// // Added new events for date and time slot
// class DateSelected extends ServiceBookingEvent {
//   final DateTime? selectedDate;  // Make it nullable

//   const DateSelected({this.selectedDate});

//   @override
//   List<Object?> get props => [selectedDate];  // Note the Object? here
// }

// class TimeSlotSelected extends ServiceBookingEvent {
//   final String selectedTimeSlot;

//   const TimeSlotSelected({required this.selectedTimeSlot});

//   @override
//   List<Object> get props => [selectedTimeSlot];
// }

// class ValidateForm extends ServiceBookingEvent {
//   final DateTime? selectedDate;
//   final String? selectedTimeSlot;

//   const ValidateForm({
//     this.selectedDate,
//     this.selectedTimeSlot,
//   });

//   @override
//   List<Object> get props => [
//         selectedDate ?? '',
//         selectedTimeSlot ?? '',
//       ];
// }


// class ConfirmPaymentForService extends ServiceBookingEvent{
//   final VendorBookingModel vendorWorkingData;

//  const ConfirmPaymentForService({required this.vendorWorkingData});

//     @override
//   List<Object?> get props => [vendorWorkingData];
// }


