import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zyra_momments_app/app/domain/usecases/payment_intent_usecases.dart';

part 'event_card_event.dart';
part 'event_card_state.dart';

class EventCardBloc extends Bloc<EventCardEvent, EventCardState> {
  final PaymentIntentUsecases paymentIntentUsecases;
  EventCardBloc(this.paymentIntentUsecases) : super(EventCardInitial()) {
    on<EventConfirmPaymentEventReqeust>(_onEventConfirmPaymemtPressed);
  }



  // Update the _onEventConfirmPaymemtPressed method in your EventCardBloc:

void _onEventConfirmPaymemtPressed(
  EventConfirmPaymentEventReqeust event,
  Emitter<EventCardState> emit,
) async {
  // Emit loading state
  emit(EventCardLoadingState(
    isSubmitting: true,
    paymentSuccess: false,
    errorMessage: null,
    zipCode: state.zipCode,
  ));

  try {
    // 1: Create payment intent from backend
    final result = await paymentIntentUsecases.createPaymentIntentForEventBookingCall(amount: event.amount);

    if (emit.isDone) return;

    if (result.isLeft()) {
      final failure = result.swap().getOrElse(() => throw Exception());
      emit(EventCardPaymentFailureState(
        errorMessage: "Failed to create payment: ${failure.message}",
        zipCode: state.zipCode,
      ));
      return;
    }

    final clientSecret = result.getOrElse(() => '');
    log("Client Secret received: $clientSecret");

    if (clientSecret.isEmpty) {
      emit(EventCardPaymentFailureState(
        errorMessage: "Invalid payment setup. Please try again.",
        zipCode: state.zipCode,
      ));
      return;
    }

    // Initialize Stripe payment sheet
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

    // 3: Present payment sheet to user
    log("Presenting payment sheet...");
    await Stripe.instance.presentPaymentSheet();

    log("Stripe payment completed successfully");

    // Step 4: Confirm payment with your backend
    log("Confirming payment with backend...");

    final confirmationResult = await paymentIntentUsecases.confirmPaymentForEventBookingCall(clientSecret);

    if (emit.isDone) return;

    confirmationResult.fold(
      (failure) {
        log("Backend confirmation failed: ${failure.message}");
        emit(EventCardPaymentFailureState(
          errorMessage: "Payment processed but confirmation failed. Please contact support.",
          zipCode: state.zipCode,
        ));
      },
      (success) {
        log("Payment completed and confirmed successfully");
        emit(EventCardPaymentSuccessState(
          zipCode: state.zipCode,
        ));
      },
    );
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

    emit(EventCardPaymentFailureState(
      errorMessage: errorMessage,
      zipCode: state.zipCode,
    ));
  } on Exception catch (e) {
    log("Exception error: $e");
    log("Exception type: ${e.runtimeType}");
    if (emit.isDone) return;
    emit(EventCardPaymentFailureState(
      errorMessage: "Payment setup failed: ${e.toString()}",
      zipCode: state.zipCode,
    ));
  } catch (e) {
    log("Unexpected error: $e");
    log("Error type: ${e.runtimeType}");
    log("Error details: ${e.toString()}");
    if (emit.isDone) return;
    emit(EventCardPaymentFailureState(
      errorMessage: "Unexpected error: ${e.toString()}",
      zipCode: state.zipCode,
    ));
  }
}

//  void _onEventConfirmPaymemtPressed(
//   EventConfirmPaymentEventReqeust event , 
//   Emitter<EventCardState> emit,
//  )async {
   
//    emit(state.copyWith(isSubmitting: true , errorMessage: null));

//    try{
     
//     // 1 : Create payment intent from backend
//     final result = await paymentIntentUsecases.createPaymentIntentForEventBookingCall(amount: event.amount);
     
//      if(emit.isDone) return;

//      if(result.isLeft()){
//        final failure = result.swap().getOrElse(()=> throw Exception());
//        emit(state.copyWith(
//         isSubmitting: false,
//         errorMessage: "Failed to create payment : ${failure.message}"
//        ));
//        return;
//      }

//      final clientSecret = result.getOrElse(()=> '');
//      log("Client Secret received: $clientSecret");

//      if(clientSecret.isEmpty){
//       emit(state.copyWith(
//         isSubmitting: false,
//         errorMessage: "Invalid payment setup. Please try again.",

//       ));
//       return;
//      }

//     //  Initialize Stripe payment sheet
//     log("Initializing Stripe payment sheet...");
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           style: ThemeMode.dark,
//           merchantDisplayName: 'Zyra Moments',
//           billingDetails: BillingDetails(
//             address: Address(
//               postalCode: state.zipCode,
//               country: 'IN',
//               city: '',
//               line1: '',
//               line2: '',
//               state: '',
//             ),
//           ),
//           appearance: PaymentSheetAppearance(
//             colors: PaymentSheetAppearanceColors(
//               primary: const Color(0xFF1976D2),
//               background: const Color(0xFF121212),
//               componentBackground: const Color(0xFF1E1E1E),
//               componentText: const Color(0xFFFFFFFF),
//               primaryText: const Color(0xFFFFFFFF),
//               secondaryText: const Color(0xFFB0B0B0),
//             ),
//             shapes: PaymentSheetShape(
//               borderRadius: 12,
//               shadow: PaymentSheetShadowParams(color: Colors.black26),
//             ),
//           ),
//         ),
//       );

//       // 3 . Present payment sheet to user
//       log("presenting payement sheet...");
//       await Stripe.instance.presentPaymentSheet();

//        log("Stripe payment completed successfully");
       

//       // Step 4: Confirm payment with your backend
//       log("Confirming payment with backend...");
      
//       final confirmationResult = await paymentIntentUsecases.confirmPaymentForEventBookingCall(clientSecret);

//       if(emit.isDone) return;

//       confirmationResult.fold((failure){
//         log("Backend confirmation failed: ${failure.message}");
//         emit(state.copyWith(
//           isSubmitting: false,
//           errorMessage: "Payment processed but confirmation failed. Please contact support. ",

//         ));
//       },
//       (success){
//         log("Payment completed and confirmed successfully");
//         emit(state.copyWith(
//           isSubmitting: false,
//           paymentSuccess: true,
//           errorMessage: null,
//         ));
//       });
//    } on StripeException catch(e){
//       log("Stripe error: ${e.error.localizedMessage ?? 'Unknown Stripe error'}");
//       log("Stripe error code: ${e.error.code}");
//       log("Stripe error type: ${e.error.type}");
//       if (emit.isDone) return;

       
//       String errorMessage;
//       switch (e.error.code) {
//         case FailureCode.Canceled:
//           errorMessage = "Payment was cancelled.";
//           break;
//         case FailureCode.Failed:
//           errorMessage = "Payment failed. Please check your payment details.";
//           break;
//         case FailureCode.Timeout:
//           errorMessage = "Payment timed out. Please try again.";
//           break;
//         default:
//           errorMessage = e.error.localizedMessage ?? "Payment failed. Please try again.";
//       }


//       emit(state.copyWith(
//         isSubmitting: false,
//         errorMessage: errorMessage,
//       ));
//    } on Exception catch (e){
//        log("Exception error: $e");
//       log("Exception type: ${e.runtimeType}");
//       if (emit.isDone) return;
//       emit(state.copyWith(
//         isSubmitting: false,
//         errorMessage: "Payment setup failed: ${e.toString()}",
//       ));
//    } catch (e){
//        log("Unexpected error: $e");
//       log("Error type: ${e.runtimeType}");
//       log("Error details: ${e.toString()}");
//       if (emit.isDone) return;
//       emit(state.copyWith(
//         isSubmitting: false,
//         errorMessage: "Unexpected error: ${e.toString()}",
//       ));
//    }
//  }
}


