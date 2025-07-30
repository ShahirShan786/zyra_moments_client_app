part of 'purchased_bloc.dart';

sealed class PurchasedEvent extends Equatable {
  const PurchasedEvent();

  @override
  List<Object> get props => [];
}

final class GetAllPurchasedTicketsRequrestEvent extends PurchasedEvent{}

final class CancelEventRequestEvent extends PurchasedEvent{
  final String eventId;

const  CancelEventRequestEvent({required this.eventId});
}
