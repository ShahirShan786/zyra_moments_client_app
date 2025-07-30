// payment_select_state.dart

import 'package:flutter_stripe/flutter_stripe.dart';

class CardPaymentState {
  final CardFieldInputDetails? cardDetails;
  final String zipCode;
  final bool isCardValid;
  final bool isZipValid;
  final bool isSubmitting;
  final String? errorMessage;
  final bool paymentSuccess;

  CardPaymentState({
    this.cardDetails,
    this.zipCode = '',
    this.isCardValid = false,
    this.isZipValid = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.paymentSuccess = false,
  });

  CardPaymentState copyWith({
    CardFieldInputDetails? cardDetails,
    String? zipCode,
    bool? isCardValid,
    bool? isZipValid,
    bool? isSubmitting,
    String? errorMessage,
    bool? paymentSuccess,
  }) {
    return CardPaymentState(
      cardDetails: cardDetails ?? this.cardDetails,
      zipCode: zipCode ?? this.zipCode,
      isCardValid: isCardValid ?? this.isCardValid,
      isZipValid: isZipValid ?? this.isZipValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      paymentSuccess: paymentSuccess ?? this.paymentSuccess,
    );
  }
}

class CardPaymentLoadingState extends CardPaymentState{

}

class CardPaymentSuccessState extends CardPaymentState{

}

class CardPaymentFailureState extends CardPaymentState{
final String errorMessages;

  CardPaymentFailureState(this.errorMessages);

//   @override
//   List<Object> get props => [errorMessages];
}