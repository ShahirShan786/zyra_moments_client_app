import 'package:flutter_bloc/flutter_bloc.dart';
// Remove NetworkCubit import from here since we're providing it directly in main.dart
// import 'package:zyra_momments_app/app/application/features/app_network/cubit/network_cubit.dart';

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
import 'package:zyra_momments_app/application/features/auth/login/bloc/login_bloc.dart';
import 'package:zyra_momments_app/application/features/auth/sign_up/bloc/auth_sign_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:zyra_momments_app/application/features/log_out/bloc/log_out_bloc.dart';
import 'package:zyra_momments_app/application/features/verification/bloc/otp_bloc.dart';

import 'package:zyra_momments_app/data/repository/forgot_password_repository_impl.dart';
import 'package:zyra_momments_app/data/repository/otp_repository_impl.dart';
import 'package:zyra_momments_app/data/repository/sign_in_repository_impl.dart';
import 'package:zyra_momments_app/domain/usercases/login_usecase.dart';
import 'package:zyra_momments_app/app/domain/usecases/payment_intent_usecases.dart';
import 'package:zyra_momments_app/app/domain/usecases/select_payment_method.dart';
import 'package:zyra_momments_app/app/domain/usecases/service_booking_usecases.dart';
import 'package:zyra_momments_app/app/domain/usecases/scan_qr_code_usercases.dart';
import 'package:zyra_momments_app/app/domain/usecases/chat_usecases.dart';
import 'package:zyra_momments_app/app/domain/repository/chat_repository.dart';

List<BlocProvider> buildBlocProviders() {
  return [
    // Remove NetworkCubit from here - it's provided directly in main.dart
    // BlocProvider(create: (_)=> NetworkCubit()),
    BlocProvider(create: (_) => NavigationBloc()),
    BlocProvider(create: (_) => HomeBloc()),
    BlocProvider(create: (_) => AuthSignBloc(SignInRepositoryImpl())),
    BlocProvider(create: (_) => OtpBloc(otpRepository: OtpRepositoryImpl())),
    BlocProvider(create: (_) => LoginBloc(LoginUsecase())),
    BlocProvider(create: (_) => ForgotPasswordBloc(ForgotPasswordRepositoryImpl())),
    BlocProvider(create: (_) => LogOutBloc()),
    BlocProvider(create: (_) => BestVendorBloc()),
    BlocProvider(create: (_) => ProfileBloc()),
    BlocProvider(create: (_) => ServiceBookingBloc(
      serviceBookingUsecases: ServiceBookingUsecases(),
      paymentIntentUsecases: PaymentIntentUsecases(),
    )),
    BlocProvider(create: (_) => AddDateBloc(
      serviceBookingBloc: ServiceBookingBloc(
        serviceBookingUsecases: ServiceBookingUsecases(),
        paymentIntentUsecases: PaymentIntentUsecases(),
      ),
    )),
    BlocProvider(create: (_) => EventBloc()),
    BlocProvider(create: (_) => DiscoverBloc()),
    BlocProvider(create: (_) => PaymentSelectBloc(SelectPaymentMethod())),
    BlocProvider(create: (_) => CardPaymentBloc(PaymentIntentUsecases())),
    BlocProvider(create: (_) => HostEventBloc()),
    BlocProvider(create: (_) => MapBloc()),
    BlocProvider(create: (_) => AddHostEventBloc()),
    BlocProvider(create: (_) => EventDateTimeBloc()),
    BlocProvider(create: (_) => EventCardBloc(PaymentIntentUsecases())),
    BlocProvider(create: (_) => PaymentBlocBloc()),
    BlocProvider(create: (_) => QrBloc(scanQrCodeUsercases: ScanQrCodeUsercases())),
    BlocProvider(create: (_) => PurchasedBloc()),
    BlocProvider(create: (_) => ChatBloc(ChatUsecases(chatRepository: ChatRepository()))),
    BlocProvider(create: (_) => HostRequestBloc()),
  ];
}