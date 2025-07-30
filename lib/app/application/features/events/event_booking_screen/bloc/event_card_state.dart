// event_card_state.dart
part of 'event_card_bloc.dart';

@immutable
abstract class EventCardState extends Equatable {
  final bool isSubmitting;
  final bool paymentSuccess;
  final String? errorMessage;
  final String? zipCode;

  const EventCardState({
    this.isSubmitting = false,
    this.paymentSuccess = false,
    this.errorMessage,
    this.zipCode,
  });

  @override
  List<Object?> get props => [isSubmitting, paymentSuccess, errorMessage, zipCode];

  EventCardState copyWith({
    bool? isSubmitting,
    bool? paymentSuccess,
    String? errorMessage,
    String? zipCode,
  });
}

class EventCardInitial extends EventCardState {
  const EventCardInitial() : super();

  @override
  EventCardInitial copyWith({
    bool? isSubmitting,
    bool? paymentSuccess,
    String? errorMessage,
    String? zipCode,
  }) {
    return EventCardInitial();
  }
}

class EventCardLoadingState extends EventCardState {
  const EventCardLoadingState({
    super.isSubmitting = true,
    super.paymentSuccess = false,
    super.errorMessage,
    super.zipCode,
  });

  @override
  EventCardLoadingState copyWith({
    bool? isSubmitting,
    bool? paymentSuccess,
    String? errorMessage,
    String? zipCode,
  }) {
    return EventCardLoadingState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      paymentSuccess: paymentSuccess ?? this.paymentSuccess,
      errorMessage: errorMessage,
      zipCode: zipCode ?? this.zipCode,
    );
  }
}

class EventCardPaymentSuccessState extends EventCardState {
  const EventCardPaymentSuccessState({
    super.isSubmitting = false,
    super.paymentSuccess = true,
    super.errorMessage,
    super.zipCode,
  });

  @override
  EventCardPaymentSuccessState copyWith({
    bool? isSubmitting,
    bool? paymentSuccess,
    String? errorMessage,
    String? zipCode,
  }) {
    return EventCardPaymentSuccessState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      paymentSuccess: paymentSuccess ?? this.paymentSuccess,
      errorMessage: errorMessage,
      zipCode: zipCode ?? this.zipCode,
    );
  }
}

class EventCardPaymentFailureState extends EventCardState {
  const EventCardPaymentFailureState({
    super.isSubmitting = false,
    super.paymentSuccess = false,
    required String errorMessage,
    super.zipCode,
  }) : super(errorMessage: errorMessage);

  @override
  EventCardPaymentFailureState copyWith({
    bool? isSubmitting,
    bool? paymentSuccess,
    String? errorMessage,
    String? zipCode,
  }) {
    return EventCardPaymentFailureState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      paymentSuccess: paymentSuccess ?? this.paymentSuccess,
      errorMessage: errorMessage ?? this.errorMessage!,
      zipCode: zipCode ?? this.zipCode,
    );
  }
}



// part of 'event_card_bloc.dart';

//  class EventCardState extends Equatable {
//   final CardFieldInputDetails? cardDetails;
//   final String zipCode;
//   final bool isCardValid;
//   final bool isZipValid;
//   final bool isSubmitting;
//   final String? errorMessage;
//   final bool paymentSuccess;
//   const EventCardState({
//     this.cardDetails,
//     this.zipCode = '',
//     this.isCardValid = false,
//     this.isZipValid = false,
//     this.isSubmitting = false,
//     this.errorMessage,
//     this.paymentSuccess = false,
//   });

//   EventCardState copyWith({
//     CardFieldInputDetails? cardDetails,
//     String? zipCode,
//     bool? isCardValid,
//     bool? isZipValid,
//     bool? isSubmitting,
//     String? errorMessage,
//     bool? paymentSuccess,
//   }){
//     return EventCardState(
//       cardDetails:cardDetails ?? this.cardDetails,
//       zipCode: zipCode ?? this.zipCode,
//       isCardValid:  isCardValid ?? this.isCardValid,
//       isZipValid: isZipValid ?? this.isZipValid,
//       isSubmitting: isSubmitting ?? this.isSubmitting,
//       errorMessage:  errorMessage,
//       paymentSuccess: paymentSuccess ?? this.paymentSuccess
//        );
//   }
  
//   @override
//   List<Object> get props => [];
// }

// final class EventCardInitial extends EventCardState {}


// final class EventCarpaymentLoadingState extends EventCardState{}

// final class EventCardPaymentSuccessState extends EventCardState{}

// final class EventCardpaymentFailureState extends EventCardState{

//   final String errorMessages;

//  const EventCardpaymentFailureState(this.errorMessages);


// }


