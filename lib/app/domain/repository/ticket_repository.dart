import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/purchased_ticket_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class TicketRepository {
  Future<Either<Failure , PurchasedTicketModel>> getAllPurchasedTicketData();
  Future<Either<Failure , void>> cancelEventRequest(String eventId);
}