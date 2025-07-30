// service_booking_bloc.dart
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_state.dart';
import 'package:zyra_momments_app/app/data/models/vendor_booking_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/service_booking_usecases.dart';
import 'package:zyra_momments_app/app/domain/usecases/payment_intent_usecases.dart';

part 'service_booking_event.dart';

class ServiceBookingBloc extends Bloc<ServiceBookingEvent, ServiceBookingState> {
  final ServiceBookingUsecases serviceBookingUsecases;
  final PaymentIntentUsecases paymentIntentUsecases;

  ServiceBookingBloc({
    required this.serviceBookingUsecases,
    required this.paymentIntentUsecases,
  }) : super(const ServiceBookingState()) {
    
    on<ServiceSelected>((event, emit) {
      emit(state.copyWith(
        selectedServiceId: event.selectedServiceId,
        vendorId: event.vendorId,
        totalAmount: event.totalAmount,
      ));
      _validateForm(emit);
    });

    on<DateSelected>((event, emit) {
      emit(state.copyWith(
        selectedDate: event.selectedDate,
      ));
      _validateForm(emit);
    });

    on<TimeSlotSelected>((event, emit) {
      emit(state.copyWith(
        selectedTimeSlot: event.selectedTimeSlot,
      ));
      _validateForm(emit);
    });

    // on<ZipCodeUpdated>((event, emit) {
    //   emit(state.copyWith(
    //     zipCode: event.zipCode,
    //   ));
    //   _validateForm(emit);
    // });

    // on<CardDetailsUpdated>((event, emit) {
    //   String? cardError;

    //   log('CardDetailsUpdated: cardNumber=${event.cardNumber}, expiryMonth=${event.expiryMonth}, expiryYear=${event.expiryYear}, cvc=${event.cvc}');

    //   // Validate card details
    //   if (event.expiryMonth == null || event.expiryMonth! < 1 || event.expiryMonth! > 12) {
    //     cardError = 'Please enter a valid expiry month (1-12)';
    //   } else if (event.expiryYear == null || event.expiryYear! < (DateTime.now().year % 100)) {
    //     cardError = 'Please enter a valid expiry year';
    //   } else if (event.cvc == null || event.cvc!.isEmpty || !RegExp(r'^\d{3,4}$').hasMatch(event.cvc!)) {
    //     cardError = 'Please enter a valid CVC (3-4 digits)';
    //   }

    //   emit(state.copyWith(cardError: cardError));
    //   _validateForm(emit);
    // });

    on<ContactNumberUpdated>((event, emit) {
      emit(state.copyWith(
        contactNumber: event.contactNumber,
      ));
      _validateForm(emit);
    });

    on<EmailUpdated>((event, emit) {
      emit(state.copyWith(
        email: event.email,
      ));
      _validateForm(emit);
    });

    on<ValidateForm>((event, emit) {
      _validateForm(emit);
    });

    on<ConfirmPaymentForService>((event, emit) async {
      await _onConfirmPaymentForService(event, emit);
    });

    // Add this handler to your ServiceBookingBloc constructor

on<ResetFormEvent>((event, emit) {
  emit(const ServiceBookingState()); // Reset to initial state
});

// // Alternative: You can also create a more explicit reset method
// void resetBloc() {
//   add(const ResetFormEvent());
// }
  }

  void _validateForm(Emitter<ServiceBookingState> emit) {
  String? formError;
  bool isFormValid = true;

  if (state.selectedServiceId == null) {
    formError = 'Please select a service';
    isFormValid = false;
  } else if (state.selectedDate == null) {
    formError = 'Please select a date';
    isFormValid = false;
  } else if (state.selectedTimeSlot == null) {
    formError = 'Please select a time slot';
    isFormValid = false;
  } else if (state.contactNumber == null || state.contactNumber!.isEmpty || state.contactNumber!.length < 10) {
    formError = 'Please enter a valid contact number';
    isFormValid = false;
  } else if (state.email == null || state.email!.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(state.email!)) {
    formError = 'Please enter a valid email address';
    isFormValid = false;
  }

  emit(state.copyWith(
    isFormValid: isFormValid,
    formError: formError,
  ));
}


  Future<void> _onConfirmPaymentForService(
    ConfirmPaymentForService event,
    Emitter<ServiceBookingState> emit,
  ) async {
    // Emit loading state
    emit(ServiceBookingLoadingState(
      selectedServiceId: state.selectedServiceId,
      zipCode: state.zipCode,
      cardError: state.cardError,
      isFormValid: state.isFormValid,
      formError: state.formError,
      vendorId: state.vendorId,
      totalAmount: state.totalAmount,
      selectedDate: state.selectedDate,
      selectedTimeSlot: state.selectedTimeSlot,
      contactNumber: state.contactNumber,
      email: state.email,
    ));

    try {
      // Step 1: Create payment intent from backend
      final result = await paymentIntentUsecases.createPaymentIntentForServiceBooking(event.vendorBookingData);

      if (emit.isDone) return;

      if (result.isLeft()) {
        final failure = result.swap().getOrElse(() => throw Exception());
        emit(ServiceBookingPaymentFailureState(
          errorMessage: "Failed to create payment: ${failure.message}",
          selectedServiceId: state.selectedServiceId,
          zipCode: state.zipCode,
          // cardError: state.cardError,
          isFormValid: state.isFormValid,
          formError: state.formError,
          vendorId: state.vendorId,
          totalAmount: state.totalAmount,
          selectedDate: state.selectedDate,
          selectedTimeSlot: state.selectedTimeSlot,
          contactNumber: state.contactNumber,
          email: state.email,
        ));
        return;
      }

      final clientSecret = result.getOrElse(() => '');
      log("Client Secret received: $clientSecret");

      if (clientSecret.isEmpty) {
        emit(ServiceBookingPaymentFailureState(
          errorMessage: "Invalid payment setup. Please try again.",
          selectedServiceId: state.selectedServiceId,
          zipCode: state.zipCode,
          cardError: state.cardError,
          isFormValid: state.isFormValid,
          formError: state.formError,
          vendorId: state.vendorId,
          totalAmount: state.totalAmount,
          selectedDate: state.selectedDate,
          selectedTimeSlot: state.selectedTimeSlot,
          contactNumber: state.contactNumber,
          email: state.email,
        ));
        return;
      }

      // Step 2: Initialize Stripe payment sheet
      log("Initializing Stripe payment sheet...");
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.dark,
          merchantDisplayName: 'Zyra Moments',
          billingDetails: BillingDetails(
            address: Address(
              postalCode: state.zipCode,
              country: 'IN',
              city: '',
              line1: '',
              line2: '',
              state: '',
            ),
            email: state.email,
            phone: state.contactNumber,
          ),
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: const Color(0xFF1976D2),
              background: const Color(0xFF121212),
              componentBackground: const Color(0xFF1E1E1E),
              componentText: const Color(0xFFFFFFFF),
              primaryText: const Color(0xFFFFFFFF),
              secondaryText: const Color(0xFFB0B0B0),
            ),
            shapes: PaymentSheetShape(
              borderRadius: 12,
              shadow: PaymentSheetShadowParams(color: Colors.black26),
            ),
          ),
        ),
      );

      // Step 3: Present payment sheet to user
      log("Presenting payment sheet...");
      await Stripe.instance.presentPaymentSheet();

      log("Stripe payment completed successfully");

      // Step 4: Create service booking
      log("Creating service booking...");

      final confirmationResult = await paymentIntentUsecases.confirmPaymentForServiceBooking(clientSecret);

       if(emit.isDone) return ;

       confirmationResult.fold((failure){
         log("Backend confirmation failed: ${failure.message}");
         emit(ServiceBookingPaymentFailureState(errorMessage: failure.message));
       }, (success){
          log("Payment completed and confirmed successfully");
          emit(ServiceBookingPaymentSuccessState(zipCode: state.zipCode));
       });
      
    } on StripeException catch (e) {
      log("Stripe error: ${e.error.localizedMessage ?? 'Unknown Stripe error'}");
      log("Stripe error code: ${e.error.code}");
      log("Stripe error type: ${e.error.type}");
      if (emit.isDone) return;

      String errorMessage;
      switch (e.error.code) {
        case FailureCode.Canceled:
          errorMessage = "Payment was cancelled.";
          break;
        case FailureCode.Failed:
          errorMessage = "Payment failed. Please check your payment details.";
          break;
        case FailureCode.Timeout:
          errorMessage = "Payment timed out. Please try again.";
          break;
        default:
          errorMessage = e.error.localizedMessage ?? "Payment failed. Please try again.";
      }

      emit(ServiceBookingPaymentFailureState(
        errorMessage: errorMessage,
        selectedServiceId: state.selectedServiceId,
        zipCode: state.zipCode,
        cardError: state.cardError,
        isFormValid: state.isFormValid,
        formError: state.formError,
        vendorId: state.vendorId,
        totalAmount: state.totalAmount,
        selectedDate: state.selectedDate,
        selectedTimeSlot: state.selectedTimeSlot,
        contactNumber: state.contactNumber,
        email: state.email,
      ));
    } on Exception catch (e) {
      log("Exception error: $e");
      log("Exception type: ${e.runtimeType}");
      if (emit.isDone) return;
      emit(ServiceBookingPaymentFailureState(
        errorMessage: "Payment setup failed: ${e.toString()}",
        selectedServiceId: state.selectedServiceId,
        zipCode: state.zipCode,
        cardError: state.cardError,
        isFormValid: state.isFormValid,
        formError: state.formError,
        vendorId: state.vendorId,
        totalAmount: state.totalAmount,
        selectedDate: state.selectedDate,
        selectedTimeSlot: state.selectedTimeSlot,
        contactNumber: state.contactNumber,
        email: state.email,
      ));
    } catch (e) {
      log("Unexpected error: $e");
      log("Error type: ${e.runtimeType}");
      log("Error details: ${e.toString()}");
      if (emit.isDone) return;
      emit(ServiceBookingPaymentFailureState(
        errorMessage: "Unexpected error: ${e.toString()}",
        selectedServiceId: state.selectedServiceId,
        zipCode: state.zipCode,
        cardError: state.cardError,
        isFormValid: state.isFormValid,
        formError: state.formError,
        vendorId: state.vendorId,
        totalAmount: state.totalAmount,
        selectedDate: state.selectedDate,
        selectedTimeSlot: state.selectedTimeSlot,
        contactNumber: state.contactNumber,
        email: state.email,
      ));
    }
  }


  
}





// // service_booking_bloc.dart
// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_state.dart';
// import 'package:zyra_momments_app/app/data/models/service_booking_reqeuest_model.dart';
// import 'package:zyra_momments_app/app/data/models/vendor_booking_model.dart';
// import 'package:zyra_momments_app/app/domain/usecases/service_booking_usecases.dart';

// part 'service_booking_event.dart';

// class ServiceBookingBloc
//     extends Bloc<ServiceBookingEvent, ServiceBookingState> {
//   ServiceBookingUsecases serviceBookingUsecases = ServiceBookingUsecases();

//   ServiceBookingBloc() : super(const ServiceBookingState()) {
//     on<ServiceSelected>((event, emit) {
//       emit(state.copyWith(
//         selectedServiceId: event.selectedServiceId,
//         vendorId: event.vendorId,
//         totalAmount: event.totalAmount,
//       ));
//       _validateForm(emit);
//     });

//     on<DateSelected>((event, emit) {
//       emit(state.copyWith(
//         selectedDate: event.selectedDate,
//       ));
//       _validateForm(emit);
//     });

//     on<TimeSlotSelected>((event, emit) {
//       emit(state.copyWith(
//         selectedTimeSlot: event.selectedTimeSlot,
//       ));
//       _validateForm(emit);
//     });

//     on<ValidateForm>((event, emit) {
//       _validateForm(emit);
//     });

//     on<ConfirmPaymentForService>((event , emit){
//       emit()
//     })
//   }

//   void _validateForm(Emitter<ServiceBookingState> emit) {
//     String? formError;
//     bool isFormValid = true;

//     // Check each field individually and set appropriate error messages
//     if (state.selectedServiceId == null) {
//       formError = 'Please select a service';
//       isFormValid = false;
//     } else if (state.selectedDate == null) {
//       formError = 'Please select a date';
//       isFormValid = false;
//     } else if (state.selectedTimeSlot == null) {
//       formError = 'Please select a time slot';
//       isFormValid = false;
//     } else if (state.zipCode == null || state.zipCode!.length != 6) {
//       formError = 'Please enter a valid 6-digit ZIP code';
//       isFormValid = false;
//     }

//     // else if (state.cardError != null) {
//     //   formError = state.cardError;
//     //   isFormValid = false;
//     // }

//     emit(state.copyWith(
//       isFormValid: isFormValid,
//       formError: formError,
//     ));
//   }
// }



// // service_booking_bloc.dart
// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_state.dart';
// import 'package:zyra_momments_app/app/data/models/service_booking_reqeuest_model.dart';
// import 'package:zyra_momments_app/app/domain/entities/service_booking_request_entity.dart';
// import 'package:zyra_momments_app/app/domain/usecases/service_booking_usecases.dart';

// part 'service_booking_event.dart';

// class ServiceBookingBloc extends Bloc<ServiceBookingEvent, ServiceBookingState> {
//   ServiceBookingUsecases serviceBookingUsecases = ServiceBookingUsecases();
//   ServiceBookingBloc() : super(const ServiceBookingState()) {
//     on<ServiceSelected>((event, emit) {
//       emit(state.copyWith(
//         selectedServiceId: event.selectedServiceId,
//         vendorId: event.vendorId,
//         totalAmount: event.totalAmount,
//       ));
//       _validateForm(emit);
//     });

//     on<ZipCodeUpdated>((event, emit) {
//       emit(state.copyWith(
//         zipCode: event.zipCode,
//       ));
//       _validateForm(emit);
//     });

//     on<CardDetailsUpdated>((event, emit) {
//   String? cardError;

//   log('CardDetailsUpdated: cardNumber=${event.cardNumber}, expiryMonth=${event.expiryMonth}, expiryYear=${event.expiryYear}, cvc=${event.cvc}');

//   // Only validate expiry and CVC; skip card number length check.
//   if (event.expiryMonth == null || event.expiryMonth! < 1 || event.expiryMonth! > 12) {
//     cardError = 'Please enter a valid expiry month (1-12)';
//   } else if (event.expiryYear == null || event.expiryYear! < (DateTime.now().year % 100)) {
//     cardError = 'Please enter a valid expiry year';
//   } 
//   // else if (event.cvc == null || event.cvc!.isEmpty || !RegExp(r'^\d{3,4}$').hasMatch(event.cvc!)) {
//   //   cardError = 'Please enter a valid CVC (3-4 digits)';
//   // }

//   emit(state.copyWith(cardError: cardError));
//   _validateForm(emit);
// });


//     on<ValidateForm>((event, emit) {
//       _validateForm(emit,
//           selectedDate: event.selectedDate, selectedTimeSlot: event.selectedTimeSlot);
//     });


//      on<PaymentIntentRequest>((event , emit)async{
//       emit(PaymentIntentLoadingState());

//       final result = await serviceBookingUsecases.serviceBookingRequest(event.reqeustData);

//       result.fold((failure){
//         emit(PaymentIntentFailureState(failure.message));
//       }, (responseData){
//         emit(PaymentIntentSuccessState(responseData: responseData));
//       });
//      });
//   }

//   void _validateForm(Emitter<ServiceBookingState> emit,
//       {String? selectedDate, String? selectedTimeSlot}) {
//     String? formError;
//     bool isFormValid = true;

//     if (state.selectedServiceId == null) {
//       formError = 'Please select a service';
//       isFormValid = false;
//     } else if (selectedDate == null) {
//       formError = 'Please select a date';
//       isFormValid = false;
//     } else if (selectedTimeSlot == null) {
//       formError = 'Please select a time slot';
//       isFormValid = false;
//     } else if (state.zipCode == null || state.zipCode!.length != 6) {
//       formError = 'Please enter a valid 5-digit ZIP code';
//       isFormValid = false;
//     } else if (state.cardError != null) {
//       formError = state.cardError;
//       isFormValid = false;
//     }

//     log('ValidateForm: formError=$formError, isFormValid=$isFormValid');
//     emit(state.copyWith(
//       isFormValid: isFormValid,
//       formError: formError,
//     ));
//   }

 
// }
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_state.dart';

// part 'service_booking_event.dart';


// class ServiceBookingBloc extends Bloc<ServiceBookingEvent, ServiceBookingState> {
//   ServiceBookingBloc() : super(ServiceBookingState()) {
//     on<ServiceSelected>((event, emit) {
//      emit(state.copyWith(selectedServiceId: event.selectedServiceId));
//     });
//   }
// }
