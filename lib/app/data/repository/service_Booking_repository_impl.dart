import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/service_booking_remote_data_source.dart';
import 'package:zyra_momments_app/app/data/models/service_booking_response_model.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/app/domain/repository/service_booking_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class ServiceBookingRepositoryImpl implements ServiceBookingRepository{
  ServiceBookingRemoteDataSource serviceBookingRemoteDataSource = ServiceBookingRemoteDataSourceImpl();
  @override
  Future<Either<Failure, List<Booking>>> getAllBookingDetails() async{
   return await serviceBookingRemoteDataSource.getAllRemoteBookingDetails();
   
  }

  @override
  Future<Either<Failure, BookingResponseModel>> serviceBookigRequest( requestData) async{
    return await serviceBookingRemoteDataSource.serviceBookingRequest(requestData);

  }
  
  @override
  Future<Either<Failure, String>> serviceBookigStatus(String bookingId, String status) {
    return serviceBookingRemoteDataSource.serviceBookingStatusRequest(bookingId, status);
   
  }
}