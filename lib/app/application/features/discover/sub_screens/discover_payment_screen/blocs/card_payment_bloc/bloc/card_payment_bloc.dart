import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zyra_momments_app/app/domain/usecases/payment_intent_usecases.dart';
import 'card_payment_state.dart';

part 'card_payment_event.dart';

class CardPaymentBloc extends Bloc<CardPaymentEvent, CardPaymentState> {
  final PaymentIntentUsecases paymentIntentUsecases;

  CardPaymentBloc(this.paymentIntentUsecases) : super(CardPaymentState()) {
    on<CardDetailsChanged>(_onCardDetailsChanged);
    on<ZipCodeChanged>(_onZipCodeChanged);
    on<ConfirmPaymentPressed>(_onConfirmPaymentPressed);
  }

  void _onCardDetailsChanged(
    CardDetailsChanged event,
    Emitter<CardPaymentState> emit,
  ) {
    final isCardValid = event.cardDetails?.complete ?? false;
    emit(state.copyWith(
      cardDetails: event.cardDetails,
      isCardValid: isCardValid,
      errorMessage: null,
    ));
  }

  void _onZipCodeChanged(
    ZipCodeChanged event,
    Emitter<CardPaymentState> emit,
  ) {
    final zip = event.zipCode.trim();
    final isZipValid = zip.length == 6 && RegExp(r'^\d{6}$').hasMatch(zip);
    emit(state.copyWith(
      zipCode: zip,
      isZipValid: isZipValid,
      errorMessage: null,
    ));
  }

  Future<void> _onConfirmPaymentPressed(
    ConfirmPaymentPressed event,
    Emitter<CardPaymentState> emit,
  ) async {
    

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      // Step 1: Create payment intent from your backend
      log("Creating payment intent...");
      final result = await paymentIntentUsecases.createPaymentIntentForDiscover(
        amount: event.amount,
      );

      if (emit.isDone) return;

      if (result.isLeft()) {
        final failure = result.swap().getOrElse(() => throw Exception());
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: "Failed to create payment: ${failure.message}",
        ));
        return;
      }

      final clientSecret = result.getOrElse(() => '');
      log("Client Secret received: $clientSecret");
      
      if (clientSecret.isEmpty) {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: "Invalid payment setup. Please try again.",
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
      
      // If we reach here, payment was successful on Stripe's side
      log("Stripe payment completed successfully");

      // Step 4: Confirm payment with your backend
      log("Confirming payment with backend...");
      final confirmationResult = await paymentIntentUsecases.confirmPayment(clientSecret);

      if (emit.isDone) return;

      confirmationResult.fold(
        (failure) {
          log("Backend confirmation failed: ${failure.message}");
          emit(state.copyWith(
            isSubmitting: false,
            errorMessage: "Payment processed but confirmation failed. Please contact support.",
          ));
        },
        (success) {
          log("Payment completed and confirmed successfully");
          emit(state.copyWith(
            isSubmitting: false,
            paymentSuccess: true,
            errorMessage: null,
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
      
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: errorMessage,
      ));
    } on Exception catch (e) {
      log("Exception error: $e");
      log("Exception type: ${e.runtimeType}");
      if (emit.isDone) return;
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: "Payment setup failed: ${e.toString()}",
      ));
    } catch (e) {
      log("Unexpected error: $e");
      log("Error type: ${e.runtimeType}");
      log("Error details: ${e.toString()}");
      if (emit.isDone) return;
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: "Unexpected error: ${e.toString()}",
      ));
    }
  }
}












