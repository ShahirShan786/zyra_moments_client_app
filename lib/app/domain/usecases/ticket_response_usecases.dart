import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/purchased_ticket_model.dart';
import 'package:zyra_momments_app/app/data/repository/ticket_reponsitory_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/ticket_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class TicketResponseUsecases {
  final TicketRepository ticketRepository = TicketReponsitoryImpl();
  Future<Either<Failure , PurchasedTicketModel>> getAllPurchasedTicketData()async{
    return await ticketRepository.getAllPurchasedTicketData();
  }

  Future<Either<Failure , void>> cancelEventRequest(String eventId)async{
    return await ticketRepository.cancelEventRequest(eventId);
  }
}