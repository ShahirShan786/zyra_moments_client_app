
import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/datasource/payment_intent_remote_data_source.dart';
import 'package:zyra_momments_app/app/data/models/ticket_response.dart';
import 'package:zyra_momments_app/app/data/models/vendor_booking_model.dart';
import 'package:zyra_momments_app/app/domain/repository/payment_intent_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class PaymentIntentRepositoryImpl implements PaymentIntentRepository{
  final PaymentIntentRemoteDataSource paymentIntentRemoteDataSource = PaymentIntentRemoteDataSourceImpl();

  // For Master of Ceremonies
  @override
  Future<Either<Failure, String>> createPaymentIntentForDiscover(String amount, String purpose) async{
    return await paymentIntentRemoteDataSource.createPaymentIntentForDiscoverFromRemote(amount, purpose);
  
  }

 @override
  Future<Either<Failure, void>> confirmPayment(String clientSecret) async{
    return await paymentIntentRemoteDataSource.confirmPayment(clientSecret);
  }

  //  For Event Booking
  
  @override
  Future<Either<Failure, String>> createPaymentIntentForEventBooking(String amount, String purpose)async {
    return await paymentIntentRemoteDataSource.createPaymentIntetForEventBokingFromRemote(amount, purpose);
  }
  
   @override
  Future<Either<Failure, void>> confirmPaymentForEventBooking(String clientSecret) async{
   return await paymentIntentRemoteDataSource.confirmPaymentForEventBooking(clientSecret);
  }

  @override
  Future<Either<Failure, TicketResponse>> getnewTicketResponse(String eventId)async {
    return await paymentIntentRemoteDataSource.getTicketDetails(eventId);
  }

  // For vendor  service booking
   @override
  Future<Either<Failure , String>> createPaymentIntentForServiceBooking(VendorBookingModel vendorBookingData)async{
    return await paymentIntentRemoteDataSource.createPaymentIntentForServiceBookingFromRemote(vendorBookingData);
  }
  @override
  Future<Either<Failure , void>> confirmPaymentForServiceBooking(String clientSecret)async{
    return await paymentIntentRemoteDataSource.confirmPaymentForServiceBooking(clientSecret);
  }
}