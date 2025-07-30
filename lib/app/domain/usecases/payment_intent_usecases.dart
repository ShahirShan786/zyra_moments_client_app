import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/models/ticket_response.dart';
import 'package:zyra_momments_app/app/data/models/vendor_booking_model.dart';
import 'package:zyra_momments_app/app/data/repository/payment_intent_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/payment_intent_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class PaymentIntentUsecases {
  final PaymentIntentRepository paymentIntentRepository = PaymentIntentRepositoryImpl();

  // For Master of Ceremonies

  Future<Either<Failure , String>> createPaymentIntentForDiscover({required String amount , String purpose = "role-upgrade" })async{
  return await paymentIntentRepository.createPaymentIntentForDiscover(amount, purpose);
  }
 
  Future<Either<Failure , void>> confirmPayment(String clientSecret)async{
  return paymentIntentRepository.confirmPayment(clientSecret);
  }


  // For Event Booking

  Future<Either<Failure , String>> createPaymentIntentForEventBookingCall({ required amount , String purpose ="ticket-purchase"})async{
   return await paymentIntentRepository.createPaymentIntentForEventBooking(amount, purpose);
  }

  Future<Either<Failure , void>> confirmPaymentForEventBookingCall(String clientSecret)async{
  return await paymentIntentRepository.confirmPaymentForEventBooking(clientSecret);
  }

  Future<Either<Failure , TicketResponse>> getNewTicketDetails(String eventId)async{
    return await paymentIntentRepository.getnewTicketResponse(eventId);
  }

  // For vendor service Booking

  Future<Either<Failure , String>> createPaymentIntentForServiceBooking(VendorBookingModel vendorBookingData)async{
    return await paymentIntentRepository.createPaymentIntentForServiceBooking(vendorBookingData);
  }

  Future<Either<Failure , void>> confirmPaymentForServiceBooking(String clientSecret)async{
    return await paymentIntentRepository.confirmPaymentForServiceBooking(clientSecret);
  }

}