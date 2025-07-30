import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zyra_momments_app/app/application/features/discover/bloc/discover_bloc.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/card_payment_bloc/bloc/card_payment_bloc.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/payment_select_bloc/bloc/payment_select_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/bloc/event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/bloc/event_card_bloc.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/payment_success_screen/bloc/payment_bloc_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/best_vendor_bloc/bloc/best_vendor_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/blocs/bloc/home_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/chat_screens/chat_screen/bloc/chat_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/qr_scanning_button/bloc/qr_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/add_date_bloc/bloc/add_date_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/bloc/host_event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/add_host_event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/event_date_time_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/map_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/host_event_details_screen/bloc/host_request_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/purchased_event_screen/bloc/purchased_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/wallet/blocs/wallet_bloc/bloc/wallet_bloc_bloc.dart';
import 'package:zyra_momments_app/app/domain/repository/chat_repository.dart';
import 'package:zyra_momments_app/app/domain/usecases/chat_usecases.dart';
import 'package:zyra_momments_app/app/domain/usecases/payment_intent_usecases.dart';
import 'package:zyra_momments_app/app/domain/usecases/scan_qr_code_usercases.dart';
import 'package:zyra_momments_app/app/domain/usecases/select_payment_method.dart';
import 'package:zyra_momments_app/app/domain/usecases/service_booking_usecases.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/features/auth/login/bloc/login_bloc.dart';
import 'package:zyra_momments_app/application/features/auth/sign_up/bloc/auth_sign_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:zyra_momments_app/application/features/log_out/bloc/log_out_bloc.dart';
import 'package:zyra_momments_app/application/features/splash/splash_screen.dart';
import 'package:zyra_momments_app/application/features/verification/bloc/otp_bloc.dart';
import 'package:zyra_momments_app/data/repository/forgot_password_repository_impl.dart';
import 'package:zyra_momments_app/data/repository/otp_repository_impl.dart';
import 'package:zyra_momments_app/data/repository/sign_in_repository_impl.dart';
import 'package:zyra_momments_app/domain/usercases/login_usecase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => AuthSignBloc(SignInRepositoryImpl())),
        BlocProvider(
            create: (context) => OtpBloc(otpRepository: OtpRepositoryImpl())),
        BlocProvider(create: (context) => LoginBloc(LoginUsecase())),
        BlocProvider(
            create: (context) =>
                ForgotPasswordBloc(ForgotPasswordRepositoryImpl())),
        BlocProvider(create: (context) => LogOutBloc()),
        BlocProvider(create: (context) => BestVendorBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(
            create: (context) => ServiceBookingBloc(
                serviceBookingUsecases: ServiceBookingUsecases(),
                paymentIntentUsecases: PaymentIntentUsecases())),
        BlocProvider(
            create: (context) => AddDateBloc(
                serviceBookingBloc: ServiceBookingBloc(
                    paymentIntentUsecases: PaymentIntentUsecases(),
                    serviceBookingUsecases: ServiceBookingUsecases()))),
        BlocProvider(create: (context) => EventBloc()),
        BlocProvider(create: (context) => DiscoverBloc()),
        BlocProvider(
            create: (context) => PaymentSelectBloc(SelectPaymentMethod())),
        BlocProvider(
            create: (context) => CardPaymentBloc(PaymentIntentUsecases())),
        BlocProvider(create: (context) => HostEventBloc()),
        BlocProvider(create: (context) => MapBloc()),
        BlocProvider(create: (context) => AddHostEventBloc()),
        BlocProvider(create: (context) => EventDateTimeBloc()),
        BlocProvider(
            create: (context) => EventCardBloc(PaymentIntentUsecases())),
        BlocProvider(create: (context) => PaymentBlocBloc()),
        BlocProvider(
            create: (context) =>
                QrBloc(scanQrCodeUsercases: ScanQrCodeUsercases())),
        BlocProvider(create: (context) => PurchasedBloc()),
        BlocProvider(
            create: (context) =>
                ChatBloc(ChatUsecases(chatRepository: ChatRepository()))),
        BlocProvider(create: (context) => HostRequestBloc()),
        BlocProvider(create: (context) => WalletBlocBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'zyra mommets',
        theme: ThemeData(
          scaffoldBackgroundColor: AppTheme.darkPrimaryColor,
          appBarTheme: AppBarTheme(backgroundColor: AppTheme.appbarColorDark),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorObservers: [routeObserver],
        home: SplashScreen(),
      ),
    );
  }
}
