part of 'payment_bloc_bloc.dart';

sealed class PaymentBlocState extends Equatable {
  const PaymentBlocState();
  
  @override
  List<Object> get props => [];
}

final class PaymentBlocInitial extends PaymentBlocState {}

final class TicketDetailsLoadingState extends PaymentBlocState{}

final class TicketDetailsSuccessState extends PaymentBlocState{
  final TicketResponse ticketDetails;

 const TicketDetailsSuccessState({required this.ticketDetails});
   @override
  List<Object> get props => [ticketDetails];
}

final class TicketDetailsFailureState extends PaymentBlocState{
  final String errorMessage;

 const TicketDetailsFailureState({required this.errorMessage});
   @override
  List<Object> get props => [errorMessage];

}