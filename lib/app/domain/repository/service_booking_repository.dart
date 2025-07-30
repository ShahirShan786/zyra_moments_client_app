import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/service_booking_reqeuest_model.dart';
import 'package:zyra_momments_app/app/data/models/service_booking_response_model.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class ServiceBookingRepository {
  Future<Either<Failure , List<Booking>>> getAllBookingDetails();
  Future<Either<Failure , BookingResponseModel>> serviceBookigRequest(BookingRequestModel requestData);
  Future<Either<Failure , String>> serviceBookigStatus(String bookingID , String status);
}