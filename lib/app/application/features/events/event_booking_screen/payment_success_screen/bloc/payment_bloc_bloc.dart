import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/ticket_response.dart';
import 'package:zyra_momments_app/app/domain/usecases/payment_intent_usecases.dart';

part 'payment_bloc_event.dart';
part 'payment_bloc_state.dart';

class PaymentBlocBloc extends Bloc<PaymentBlocEvent, PaymentBlocState> {
  PaymentIntentUsecases paymentIntentUsecases = PaymentIntentUsecases();
  PaymentBlocBloc() : super(PaymentBlocInitial()) {
    on<GetTicketDetailsReqeust>((event, emit)async {
      emit(TicketDetailsLoadingState());
        log("Requesting ticket details for eventId: ${event.eventId}");
      final result = await paymentIntentUsecases.getNewTicketDetails(event.eventId);

      result.fold((failure){
         log("Ticket details failure: ${failure.message}");
        emit(TicketDetailsFailureState(errorMessage: failure.message));
      }, (ticketDetails){
         log("Ticket details success: ${ticketDetails.ticket.ticketId}");
        emit(TicketDetailsSuccessState(ticketDetails: ticketDetails));
      });

    });
  }
}
