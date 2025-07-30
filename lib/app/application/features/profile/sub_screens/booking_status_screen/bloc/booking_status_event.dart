part of 'booking_status_bloc.dart';

sealed class BookingStatusEvent extends Equatable {
  const BookingStatusEvent();

  @override
  List<Object> get props => [];
}


class GetAllBookingStatusRequestEvent extends BookingStatusEvent{}

class UpdatBookingStatusEvent extends BookingStatusEvent{
  final String bookingId;
  final String status;

 const UpdatBookingStatusEvent({required this.bookingId, required this.status});

   @override
  List<Object> get props => [bookingId , status];
}