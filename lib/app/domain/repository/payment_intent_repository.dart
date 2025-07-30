import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/ticket_response.dart';
import 'package:zyra_momments_app/app/data/models/vendor_booking_model.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class PaymentIntentRepository {
//  For Master of ceremonies
  Future<Either<Failure , String >> createPaymentIntentForDiscover(String amount , String purpose);
  Future<Either<Failure , void>> confirmPayment(String clientSecret);

  // For Event booking 
  
  Future<Either<Failure , String>> createPaymentIntentForEventBooking(String amount , String purpose);
  Future<Either<Failure , void>> confirmPaymentForEventBooking(String clientSecret);
  Future<Either<Failure , TicketResponse>> getnewTicketResponse(String eventId);

  // For vendor service booking

  Future<Either<Failure , String>> createPaymentIntentForServiceBooking(VendorBookingModel vendorBookingData);
  Future<Either<Failure , void>> confirmPaymentForServiceBooking(String clientSecret);
}