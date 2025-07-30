import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';
import 'package:zyra_momments_app/application/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:zyra_momments_app/application/features/forgot_password/otp_verifiaction_screen.dart';

// ignore: must_be_immutable
class AddEmailScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is OtpLoading) {
          Center(child: CircularProgressIndicator());
        } else if (state is OtpSendState) {
          Navigator.of(context).pop();
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) =>
                  OtpVerificationScreen(email: emailController.text)));
//         Future.microtask(() {
//   if (ModalRoute.of(context)!.isCurrent) {
//     Navigator.of(context).push(
//       CupertinoPageRoute(builder: (context) => OtpVerificationScreen(email: emailController.text)),
//     );
//   }
// });
        }else if(state is OtpfailureState){
          showFailureScackbar(context: context, height: height, title: "Fail to send OTP", body: state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.darkPrimaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.darkTextColorPrymary,
              )),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: "amaranth",
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: height * 0.012,
                  ),
                  Text(
                    "Enter your email address with your account and we'll send\nan email with confirmation to reset your\npassword.",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'open',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 25),
                    child: CustomText(text: "Email"),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Enter your email here",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.022,
                  ),
                  PrimaryButton(
                      label: "Send OTP",
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          String email = emailController.text;

                          BlocProvider.of<ForgotPasswordBloc>(context)
                              .add(SendotpEvent(email));
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
