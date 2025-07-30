import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKey {
  final baseUrl = "https://api.zyramoment.shop";

  final nPoint = "/api/v_1/auth/";
  final clientlogout = "v_1/_pvt/_cl/client/logout";

  final clientNpoint = '/api/v_1/_pvt/_cl/client/';
  final client = "/api/v_1/_pvt/_pmt/client/";
  final getCategories = 'categories';
  final getBestVendors = "best-vendors";
  final getAllBookingDetails = "client-bookings";
  final serviceBookingRequest =
      "/api/v_1/_pvt/_pmt/client/create-payment-intent";
  final getAllEvnetList = "api/v_1/_pvt/_host/client/upcomings";
  final getAllTransaction = "transactions";
  final getWallet = "wallet";
  final upcomings = "/api/v_1/_pvt/_host/client/upcomings";
  final createPaymentIntent = "/api/v_1/_pvt/_pmt/client/create-payment-intent";
  final confirmPayment = "confirm-payment";
}

String Publishablekey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;

String Secretkey = dotenv.env['STRIPE_SECRET_KEY']!;
String googleClientId = dotenv.env['GOOGLE_CLIENT_ID']!;
    

// http://localhost:8080


// 705381

