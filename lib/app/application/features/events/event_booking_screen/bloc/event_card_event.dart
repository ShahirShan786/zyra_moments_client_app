part of 'event_card_bloc.dart';

sealed class EventCardEvent extends Equatable {
  const EventCardEvent();

  @override
  List<Object> get props => [];
}

class EventConfirmPaymentEventReqeust extends EventCardEvent{
  final String amount;

 const EventConfirmPaymentEventReqeust({required this.amount});
   @override
  List<Object> get props => [amount];
}



