part of 'card_payment_bloc.dart';

sealed class CardPaymentEvent extends Equatable {
  const CardPaymentEvent();

  @override
  List<Object> get props => [];
}

class CardDetailsChanged extends CardPaymentEvent{
  final CardFieldInputDetails? cardDetails;

  const CardDetailsChanged(this.cardDetails);
}

class ZipCodeChanged extends CardPaymentEvent{
  final String zipCode;

  const ZipCodeChanged(this.zipCode);
}

class ConfirmPaymentPressed extends CardPaymentEvent {
  final String amount;

 const ConfirmPaymentPressed({required this.amount});

   @override
  List<Object> get props => [amount];
  
}