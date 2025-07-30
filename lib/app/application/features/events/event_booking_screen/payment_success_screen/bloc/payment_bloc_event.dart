part of 'payment_bloc_bloc.dart';

sealed class PaymentBlocEvent extends Equatable {
  const PaymentBlocEvent();

  @override
  List<Object> get props => [];
}


class GetTicketDetailsReqeust extends PaymentBlocEvent{
  final String eventId;

 const GetTicketDetailsReqeust({required this.eventId});
   @override
  List<Object> get props => [eventId];
}
