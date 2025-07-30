import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/features/auth/sign_up/bloc/auth_sign_bloc.dart';
import 'package:zyra_momments_app/application/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:zyra_momments_app/application/features/verification/bloc/otp_bloc.dart';
import 'package:zyra_momments_app/application/features/verification/bloc/otp_state.dart';
import 'package:zyra_momments_app/application/features/verification/widgets/input_box.dart';


class VerificationCodeScreen extends StatefulWidget {
  final String email;
  final String password;
  const VerificationCodeScreen(
      {super.key, required this.email, required this.password});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late OtpBloc otpBloc;
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

  @override
  void initState() {
    otpBloc = BlocProvider.of<OtpBloc>(context);

    otpBloc.add(SendOTPEvent(email: widget.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
            BlocConsumer<OtpBloc, OtpState>(
              listener: (context, state) {
                if (state is OTPTimeRunnig && state.secondsLeft == 59) {
                  showPrimarySnackBar(context, height);
                } else if (state is OTPVerificationSuccess) {
                  context.read<AuthSignBloc>().add(RegisterUserEvent(
                      email: widget.email, password: widget.password));
                } else if (state is OtpfailureState) {
                  showFailureScackbar(
                      context: context,
                      height: height,
                      title: "Time Expired",
                      body: 'OTP expired. plese try again.');
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
                          if (state is OTPLoading)
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
                          if (state is OTPTimeRunnig && state.secondsLeft > 0)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomText(
                                text: "Resend in ${state.secondsLeft}s",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkTextColorSecondary,
                              ),
                            ),
                          if (state is OTPFailure ||
                              (state is OTPTimeRunnig &&
                                  state.secondsLeft == 0))
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 90, vertical: 10),
                              child: InkWell(
                                onTap: () => otpBloc
                                    .add(ResendOTPEvent(email: widget.email)),
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
                         
                        }
                      },
                      builder: (context, state) {
                        return PrimaryButton(
                            label: "Verify OTP",
                            ontap: () {
                              String otp = getOtp();
                              BlocProvider.of<OtpBloc>(context).add(
                                  VerifyOTPEvent(
                                      email: widget.email, otp: otp));
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
