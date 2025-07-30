part of 'purchased_bloc.dart';

sealed class PurchasedState extends Equatable {
  const PurchasedState();
  
  @override
  List<Object> get props => [];
}

final class PurchasedInitial extends PurchasedState {}

// For get Purchased ticket Events

final class PurchasedTicketLoadingState extends PurchasedState{}

final class PurchasedTicketSuccessState extends PurchasedState{
  final List<Ticket> purchasedEventList;

const  PurchasedTicketSuccessState({required this.purchasedEventList});

  
  @override
  List<Object> get props => [purchasedEventList];
}

final class PurchasedTicketFailureState extends PurchasedState{
  final String errorMessage;

const  PurchasedTicketFailureState({required this.errorMessage});
}

// For Cancel Purchased event

final class CancelTicketLoadingState extends PurchasedState{}

final class CancelTicketSuccessState extends PurchasedState{
  final String cancelledEventId;

 const CancelTicketSuccessState({required this.cancelledEventId});

  @override
  List<Object> get props => [cancelledEventId];
}


final class CancelTicketFailureState extends PurchasedState{
  final String errorMessage;

 const CancelTicketFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

