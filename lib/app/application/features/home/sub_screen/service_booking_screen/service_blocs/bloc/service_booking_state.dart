// service_booking_state.dart
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/service_booking_response_model.dart';

class ServiceBookingState extends Equatable {
  final String? selectedServiceId;
  final bool isFormValid;
  final String? formError;
  final String? vendorId;
  final int? totalAmount;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;
  final bool isSubmitting;
  final bool paymentSuccess;
  final String? errorMessage;
  final String? zipCode;
  final String? cardError;
  final String? contactNumber;
  final String? email;

  const ServiceBookingState({
    this.selectedServiceId,
    this.isFormValid = false,
    this.formError,
    this.vendorId,
    this.totalAmount,
    this.selectedDate,
    this.selectedTimeSlot,
    this.errorMessage,
    this.paymentSuccess = false,
    this.isSubmitting = false,
    this.zipCode,
    this.cardError,
    this.contactNumber,
    this.email,
  });

  ServiceBookingState copyWith({
    String? selectedServiceId,
    String? zipCode,
    String? cardError,
    bool? isFormValid,
    String? formError,
    String? vendorId,
    int? totalAmount,
    DateTime? selectedDate,
    String? selectedTimeSlot,
    bool? isSubmitting,
    bool? paymentSuccess,
    String? errorMessage,
    String? contactNumber,
    String? email,
  }) {
    return ServiceBookingState(
      selectedServiceId: selectedServiceId ?? this.selectedServiceId,
      isFormValid: isFormValid ?? this.isFormValid,
      formError: formError ?? this.formError,
      vendorId: vendorId ?? this.vendorId,
      totalAmount: totalAmount ?? this.totalAmount,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      paymentSuccess: paymentSuccess ?? this.paymentSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      zipCode: zipCode ?? this.zipCode,
      cardError: cardError ?? this.cardError,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        selectedServiceId,
        zipCode,
        cardError,
        isFormValid,
        formError,
        vendorId,
        totalAmount,
        selectedDate,
        selectedTimeSlot,
        isSubmitting,
        paymentSuccess,
        errorMessage,
        contactNumber,
        email,
      ];
}

class ServiceBookingLoadingState extends ServiceBookingState {
  const ServiceBookingLoadingState({
    super.selectedServiceId,
    super.zipCode,
    super.cardError,
    super.isFormValid,
    super.formError,
    super.vendorId,
    super.totalAmount,
    super.selectedDate,
    super.selectedTimeSlot,
    super.isSubmitting = true,
    super.paymentSuccess = false,
    super.errorMessage,
    super.contactNumber,
    super.email,
  });
}

class ServiceBookingPaymentSuccessState extends ServiceBookingState {
  final BookingResponseModel? responseData;

  const ServiceBookingPaymentSuccessState({
    super.selectedServiceId,
    super.zipCode,
    super.cardError,
    super.isFormValid,
    super.formError,
    super.vendorId,
    super.totalAmount,
    super.selectedDate,
    super.selectedTimeSlot,
    super.paymentSuccess = true,
    super.isSubmitting = false,
    super.contactNumber,
    super.email,
    this.responseData,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        responseData,
      ];
}

class ServiceBookingPaymentFailureState extends ServiceBookingState {
  const ServiceBookingPaymentFailureState({
    required String errorMessage,
    super.selectedServiceId,
    super.zipCode,
    super.cardError,
    super.isFormValid,
    super.formError,
    super.vendorId,
    super.totalAmount,
    super.selectedDate,
    super.selectedTimeSlot,
    super.paymentSuccess = false,
    super.isSubmitting = false,
    super.contactNumber,
    super.email,
  }) : super(errorMessage: errorMessage);
}



// // service_booking_state.dart
// import 'package:equatable/equatable.dart';
// import 'package:zyra_momments_app/app/data/models/service_booking_response_model.dart';

// class ServiceBookingState extends Equatable {
//   final String? selectedServiceId;
 
//   final bool isFormValid;
//   final String? formError;
//   final String? vendorId;
//   final int? totalAmount;
//   final DateTime? selectedDate; // Added
//   final String? selectedTimeSlot; // Added
//   final bool isSubmitting;
//   final bool paymentSuccess;
//   final String? errorMessage;
//   final String? zipCode;


//   const ServiceBookingState({
//     this.selectedServiceId,
//     this.isFormValid = false,
//     this.formError,
//     this.vendorId,
//     this.totalAmount,
//     this.selectedDate, // Added
//     this.selectedTimeSlot, // Added
//     this.errorMessage,
//     this.paymentSuccess = false,
//     this.isSubmitting = false,
//     this.zipCode

    
//   });

//   ServiceBookingState copyWith({
//     String? selectedServiceId,
//     String? zipCode,
//     String? cardError,
//     bool? isFormValid,
//     String? formError,
//     String? vendorId,
//     int? totalAmount,
//     DateTime? selectedDate, // Added
//     String? selectedTimeSlot, 
//      bool? isSubmitting,
//     bool? paymentSuccess,
//     String? errorMessage,
//     // Added
//   }) {
//     return ServiceBookingState(
//       selectedServiceId: selectedServiceId ?? this.selectedServiceId,
//       isFormValid: isFormValid ?? this.isFormValid,
//       formError: formError ?? this.formError,
//       vendorId: vendorId ?? this.vendorId,
//       totalAmount: totalAmount ?? this.totalAmount,
//       selectedDate: selectedDate ?? this.selectedDate, // Added
//       selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
//       isSubmitting: isSubmitting ?? this.isSubmitting ,// Added,
//       paymentSuccess: paymentSuccess ?? this.paymentSuccess,
//       errorMessage:  errorMessage ?? this.errorMessage,
//       zipCode:  zipCode ?? this.zipCode
//     );
//   }

//   @override
//   List<Object?> get props => [
//         selectedServiceId,
//         zipCode,
//         // cardError,
//         isFormValid,
//         formError,
//         vendorId,
//         totalAmount,
//         selectedDate, // Added
//         selectedTimeSlot, // Added
//       ];
// }

// class PaymentIntentLoadingState extends ServiceBookingState {
//   const PaymentIntentLoadingState({
//     super.selectedServiceId,
//     super.zipCode,
//     // super.cardError,
//     super.isFormValid,
//     super.formError,
//     super.vendorId,
//     super.totalAmount,
//     super.selectedDate,
//     super.selectedTimeSlot,
//     super.isSubmitting = true,
//     super.paymentSuccess = false,
//     super.errorMessage,
    
//   });
// }

// class PaymentIntentSuccessState extends ServiceBookingState {
//   final BookingResponseModel responseData;

//   const PaymentIntentSuccessState({
//     super.selectedServiceId,
//     super.zipCode,
//     // super.cardError,
//     super.isFormValid,
//     super.formError,
//     super.vendorId,
//     super.totalAmount,
//     super.selectedDate,
//     super.selectedTimeSlot,
//     required this.responseData,
//   });

//   @override
//   List<Object?> get props => [
//         selectedServiceId,
//         zipCode,
//         // cardError,
//         isFormValid,
//         formError,
//         vendorId,
//         totalAmount,
//         selectedDate,
//         selectedTimeSlot,
//         responseData,
//       ];
// }

// class PaymentIntentFailureState extends ServiceBookingState {
//   final String errorMessage;

//   const PaymentIntentFailureState(
//     this.errorMessage, {
//     super.selectedServiceId,
//     super.zipCode,
//     // super.cardError,
//     super.isFormValid,
//     super.formError,
//     super.vendorId,
//     super.totalAmount,
//     super.selectedDate,
//     super.selectedTimeSlot,
//   });

//   @override
//   List<Object?> get props => [
//         selectedServiceId,
//         zipCode,
//         // cardError,
//         isFormValid,
//         formError,
//         vendorId,
//         totalAmount,
//         selectedDate,
//         selectedTimeSlot,
//         errorMessage,
//       ];
// }

// class ServiceCardLoadingState extends ServiceBookingState{
  
// }
