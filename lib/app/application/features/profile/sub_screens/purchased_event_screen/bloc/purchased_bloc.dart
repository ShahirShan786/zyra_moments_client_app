import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/purchased_ticket_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/ticket_response_usecases.dart';

part 'purchased_event.dart';
part 'purchased_state.dart';

class PurchasedBloc extends Bloc<PurchasedEvent, PurchasedState> {
  TicketResponseUsecases ticketResponseUsecases = TicketResponseUsecases();
  PurchasedBloc() : super(PurchasedInitial()) {
    on<GetAllPurchasedTicketsRequrestEvent>((event, emit) async {
      emit(PurchasedTicketLoadingState());
      final result = await ticketResponseUsecases.getAllPurchasedTicketData();

      result.fold((failure) {
        emit(PurchasedTicketFailureState(errorMessage: failure.message));
      }, (purchasedData) {
        emit(PurchasedTicketSuccessState(
            purchasedEventList: purchasedData.tickets));
      });
    });

    on<CancelEventRequestEvent>((event, emit) async {
      log("🔄 Cancelling event with ID: ${event.eventId}");
      emit(CancelTicketLoadingState());

      final result =
          await ticketResponseUsecases.cancelEventRequest(event.eventId);

      result.fold(
        (failure) {
          log("❌ Failed to cancel ticket: ${failure.message}");
          emit(CancelTicketFailureState(errorMessage: failure.message));
        },
        (success) {
          log("✅ Successfully cancelled ticket with ID: ${event.eventId}");
          emit(CancelTicketSuccessState(cancelledEventId: event.eventId));
        },
      );
    });
  }
}
