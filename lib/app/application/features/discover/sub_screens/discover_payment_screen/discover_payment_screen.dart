// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/card_payment_bloc/bloc/card_payment_bloc.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/card_payment_bloc/bloc/card_payment_state.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/payment_select_bloc/bloc/payment_select_bloc.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/payment_select_bloc/bloc/payment_select_event.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/blocs/payment_select_bloc/bloc/payment_select_state.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/widgets/payment_option_tile.dart';
import 'package:zyra_momments_app/app/application/features/discover/sub_screens/discover_payment_screen/widgets/show_descover_success_dialog.dart';
import 'package:zyra_momments_app/app/domain/entities/payment_method.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class DiscoverPaymentScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const DiscoverPaymentScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Image
              Container(
                width: double.infinity,
                height: height * 0.25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/discover_8.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    CustomText(
                      text: "Complete Your Payment",
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w800,
                      FontFamily: "amaranth",
                    ),

                    // User Info Card
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        width: double.infinity,
                        height: height * 0.12,
                        decoration: BoxDecoration(
                          color: AppTheme.darkSecondaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            spacing: height * 0.003,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Role Upgrade Fee : ₹49.99",
                                fontSize: height * 0.028,
                                fontWeight: FontWeight.w500,
                                FontFamily: "amaranth",
                              ),
                              CustomText(
                                text: "Name : $firstName $lastName",
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkTextLightColor,
                              ),
                              CustomText(
                                text: "Email : $email",
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkTextLightColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Payment Methods Section
                    CustomText(
                      text: "Payment Methods :",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: "Select your preferred payment method",
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkTextLightColor,
                    ),
                    SizedBox(height: height * 0.01),

                    // Payment Options
                    BlocListener<CardPaymentBloc, CardPaymentState>(
                      listener: (context, state) {
                        if (state.paymentSuccess && !state.isSubmitting) {
                          showDiscoverSuccessDialog(context);
                        } else if (state.errorMessage != null && !state.isSubmitting) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage!),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<PaymentSelectBloc, PaymentSelectState>(
                        builder: (context, state) {
                          PaymentMethods? selectedMethod;
                          if (state is PaymentMethodSelected) {
                            selectedMethod = state.selectedMethod;
                          }
                          return Column(
                            children: [
                              PaymentOptionTile(
                                title: "Debit Card / Credit Card",
                                isSelected: selectedMethod == PaymentMethods.debitCreditCard,
                                onTap: () {
                                  context.read<PaymentSelectBloc>().add(
                                    const SelectPaymentMethodEvent(
                                      selectedMethod: PaymentMethods.debitCreditCard,
                                    ),
                                  );
                                },
                                indicatorColors: AppTheme.indicatorColors,
                              ),
                              PaymentOptionTile(
                                title: "Bank Transfer",
                                isSelected: selectedMethod == PaymentMethods.bankTransfer,
                                onTap: () {
                                  context.read<PaymentSelectBloc>().add(
                                    const SelectPaymentMethodEvent(
                                      selectedMethod: PaymentMethods.bankTransfer,
                                    ),
                                  );
                                },
                              ),
                              PaymentOptionTile(
                                title: "UPI Method",
                                isSelected: selectedMethod == PaymentMethods.upiMethod,
                                onTap: () {
                                  context.read<PaymentSelectBloc>().add(
                                    const SelectPaymentMethodEvent(
                                      selectedMethod: PaymentMethods.upiMethod,
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    SizedBox(height: height * 0.01),
                    CustomText(
                      text: "Complete Your Payment",
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: height * 0.015),

                    // Continue Payment Button
                    BlocBuilder<CardPaymentBloc, CardPaymentState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: state.isSubmitting
                                ? null
                                : () {
                                    context.read<CardPaymentBloc>().add(
                                      ConfirmPaymentPressed(amount: "49"), // in paisa
                                    );
                                  },
                            child: Container(
                              width: double.infinity,
                              height: height * 0.065,
                              decoration: BoxDecoration(
                                color: state.isSubmitting
                                    ? Colors.grey
                                    : AppTheme.paymentButtonColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: state.isSubmitting
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        CustomText(
                                          text: "Processing...",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    )
                                  : CustomText(
                                      text: "Continue Payment - ₹49.99",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


