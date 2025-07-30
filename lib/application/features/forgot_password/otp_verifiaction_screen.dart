import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/features/auth/sign_up/bloc/auth_sign_bloc.dart';
import 'package:zyra_momments_app/application/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:zyra_momments_app/application/features/forgot_password/reset_password_screen.dart';
import 'package:zyra_momments_app/application/features/verification/widgets/input_box.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool snackbarShown = false;
  late ForgotPasswordBloc forgotPasswordBloc;
  //  late AuthSignBloc authSignBloc;
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }

  void clearOtp() {
    for (var controller in otpControllers) {
      controller.clear();
    }
  }

  @override
  void initState() {
    forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    final currentState = forgotPasswordBloc.state;
    if (currentState is! OtpSendState && currentState is! OtpLoading) {
      forgotPasswordBloc.add(SendotpEvent(widget.email)); // Send OTP Only Once
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return  Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: "Verifiaction Code",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                FontFamily: 'amaranth',
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: "Please enter the 6-digit code sent to your email.",
                color: AppTheme.darkTextColorSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                FontFamily: 'roboto',
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Form(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      6,
                      (index) => inputBox(
                          height: height,
                          width: width,
                          controller: otpControllers[index]))),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is OtpTimeRunnig && state.secondsLeft == 59) {
                  showPrimarySnackBar(context, height);
                } else if (state is OtpVerifySuccessState) {
                 showSuccessSnackbar(
                      context: context,
                      height: height,
                      title: "OTP Verified",
                      body: "Your email has been successfully verified.");
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => ResetPasswordScreen(
                              email: widget.email,
                            )));
                  });
                } else if (state is OtpfailureState) {
                  log("OTP Verification Failed!");
                  showFailureScackbar(
                      context: context,
                      height: height,
                      title: "Varification failed",
                      body: state.errorMessage);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: height * 0.09,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          if (state is OtpLoading)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: CustomText(
                                    text: "Sending OTP..",
                                    fontSize: 18,
                                  ),
                                ),
                                CircularPercentIndicator(
                                  radius: 11,
                                  lineWidth: 3.0,
                                  percent: state.progress,
                                  progressColor: Colors.blue,
                                  backgroundColor: Colors.grey.shade300,
                                  circularStrokeCap: CircularStrokeCap.round,
                                )
                              ],
                            ),
                          // SizedBox(
                          //   height: height * 0.02,
                          // ),
                          if (state is OtpTimeRunnig && state.secondsLeft > 0)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomText(
                                text: "Resend in ${state.secondsLeft}s",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkTextColorSecondary,
                              ),
                            ),
                          if (state is OtpfailureState ||
                              (state is OtpTimeRunnig &&
                                  state.secondsLeft == 0))
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 90, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                   forgotPasswordBloc
                                .add(ResendOtpEvent(email: widget.email));
                            clearOtp();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: height * 0.055,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppTheme.darkBorderColor),
                                        color: AppTheme.darkPrimaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: "Resend OTP",
                                          color: AppTheme.darkTextColorPrymary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                        ],
                      ),
                    ),
                    BlocConsumer<AuthSignBloc, AuthSignState>(
                      listener: (context, authState) {
                        if (authState is AuthSignStateSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Registration Successful!'),
                            backgroundColor: Colors.green,
                          ));
                        }
                      },
                      builder: (context, state) {
                        return PrimaryButton(
                            label: "Verify OTP",
                            ontap: () {
                              FocusScope.of(context).unfocus();
                              String otp = getOtp();
                              log(otp);
                              BlocProvider.of<ForgotPasswordBloc>(context)
                                  .add(VerifyotpEvent(widget.email, otp));
                            });
                      },
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    ));
  }
}
