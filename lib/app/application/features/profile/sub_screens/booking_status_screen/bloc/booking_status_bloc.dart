import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/service_booking_usecases.dart';

part 'booking_status_event.dart';
part 'booking_status_state.dart';

class BookingStatusBloc extends Bloc<BookingStatusEvent, BookingStatusState> {
  ServiceBookingUsecases serviceBookingUsecases = ServiceBookingUsecases();
  BookingStatusBloc() : super(BookingStatusInitial()) {
    on<GetAllBookingStatusRequestEvent>((event, emit)async {
     emit(BookingStatusLoadingState());

      final result = await  serviceBookingUsecases.getAllBookingDetails();

      result.fold((failure){
        emit(BookingStatusFailureState(errorMessage: failure.message));
      }, (booking){
         emit(BookingStatusSuccessState(bookings: booking));
      });
    });

   on<UpdatBookingStatusEvent>((event, emit) async {
  emit(BookingStatusLoadingState());

  final result = await serviceBookingUsecases.serviceBookingStatusRequest(event.bookingId, event.status);

  await result.fold(
    (failure) async {
      emit(BookingStatusFailureState(errorMessage: failure.message));
    },
    (_) async {
      final updatedResult = await serviceBookingUsecases.getAllBookingDetails();

      updatedResult.fold(
        (failure) => emit(BookingStatusFailureState(errorMessage: failure.message)),
        (bookings) => emit(BookingStatusSuccessState(bookings: bookings)),
      );
    },
  );
});

  }
}
