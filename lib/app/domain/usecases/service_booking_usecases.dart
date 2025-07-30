import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/service_booking_response_model.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/app/data/repository/service_Booking_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/service_booking_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class ServiceBookingUsecases {
  ServiceBookingRepository serviceBookingRepository = ServiceBookingRepositoryImpl();
  Future<Either<Failure , List<Booking>>> getAllBookingDetails(){
    return serviceBookingRepository.getAllBookingDetails();
  }

  Future<Either<Failure , BookingResponseModel>> serviceBookingRequest( requestData){
    return serviceBookingRepository.serviceBookigRequest(requestData);
  }

  Future<Either<Failure , String>> serviceBookingStatusRequest(String bookingId , String status){
    return serviceBookingRepository.serviceBookigStatus(bookingId, status);
  }
}