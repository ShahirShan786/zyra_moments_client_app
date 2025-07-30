import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';
import 'package:zyra_momments_app/application/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:zyra_momments_app/application/features/forgot_password/success_screen.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatelessWidget {
  final String email;
  ResetPasswordScreen({super.key, required this.email});

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is LoadingState) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Center(child: CircularProgressIndicator()));
        } else if (state is PasswordResetSuccessState) {
          Navigator.of(context)
              .push(CupertinoPageRoute(builder: (context) => SuccessScreen()));
        } else if (state is PasswordResetFailureState) {
          showFailureScackbar(
              context: context,
              height: height,
              title: "Password Reset Failed",
              body: state.message);
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
                    "Create New Password",
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
                    "This password should be different from the previous\npassword",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'open',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 25),
                    child: CustomText(text: "Password"),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomTextField(
                    controller: newPasswordController,
                    hintText: "Enter your password here",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      } else if (!RegExp(
                              r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
                          .hasMatch(value)) {
                        return 'Password must contain at least 1 uppercase letter, 1 number, and 1 special character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.022,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 0),
                    child: CustomText(text: "Confirm Password"),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CustomTextField(
                    controller: confirmNewPasswordController,
                    hintText: "Enter your email here",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      } else if (!RegExp(
                              r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
                          .hasMatch(value)) {
                        return 'Password must contain at least 1 uppercase letter, 1 number, and 1 special character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.022,
                  ),
                  PrimaryButton(
                      label: "Reset Password",
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          if (newPasswordController.text ==
                              confirmNewPasswordController.text) {
                            String userEmail = email;
                            String newPassword = newPasswordController.text;
                            BlocProvider.of<ForgotPasswordBloc>(context).add(
                                ResetPasswordEvent(userEmail, newPassword));
                          }
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
