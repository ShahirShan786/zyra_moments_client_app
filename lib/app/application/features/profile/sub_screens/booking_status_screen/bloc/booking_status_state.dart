part of 'booking_status_bloc.dart';

sealed class BookingStatusState extends Equatable {
  const BookingStatusState();
  
  @override
  List<Object> get props => [];
}

final class BookingStatusInitial extends BookingStatusState {}

final class BookingStatusLoadingState extends BookingStatusState{

}

final class BookingStatusSuccessState extends BookingStatusState{
  final List<Booking> bookings;

 const BookingStatusSuccessState({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class BookingStatusFailureState extends BookingStatusState{
  final String errorMessage;

 const BookingStatusFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}