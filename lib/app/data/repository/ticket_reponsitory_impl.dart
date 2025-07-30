import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/ticket_response_data_source.dart';
import 'package:zyra_momments_app/app/data/models/purchased_ticket_model.dart';
import 'package:zyra_momments_app/app/domain/repository/ticket_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class TicketReponsitoryImpl implements TicketRepository{
  final TicketResponseDataSource ticketResponseDataSource = TicketResponseDataSourceImpl();
  @override
  Future<Either<Failure, PurchasedTicketModel>> getAllPurchasedTicketData() async{
  return await ticketResponseDataSource.getAllPurchasedTicketResponseFromDataSource();
  }
  
  @override
  Future<Either<Failure, void>> cancelEventRequest(String eventId)async {
    return await ticketResponseDataSource.cancelRequestEventFromRemoteDataSource(eventId);
  }
}