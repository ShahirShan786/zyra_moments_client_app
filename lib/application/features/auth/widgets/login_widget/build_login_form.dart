import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';
import 'package:zyra_momments_app/application/features/auth/login/bloc/login_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';
import 'package:zyra_momments_app/application/features/forgot_password/add_email_screen.dart';

Widget buildLoginForm(
    BuildContext context,
    double height,
    GlobalKey<FormState> loginFormKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController logEmailController,
    TextEditingController logPasswordController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    child: BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) => _handleLoginState(
          context, state, height, emailController, passwordController),
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: height * 0.46,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.darkBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Form(
            key: loginFormKey,
            child: Column(
              children: [
                _buildLoginHeader(height),
                _buildEmailField(logEmailController),
                _buildPasswordField(state, context, logPasswordController),
                SizedBox(height: height * 0.02),
                _buildLoginButton(context, loginFormKey, logEmailController,
                    logPasswordController),
                _buildForgotPasswordLink(context),
              ],
            ),
          ),
        );
      },
    ),
  );
}

void _handleLoginState(
    BuildContext context,
    LoginState state,
    double height,
    TextEditingController emailController,
    TextEditingController passwordController) {
  if (state is LoginStateSuccess) {
    _handleLoginSuccess(context, height, emailController, passwordController);
  } else if (state is LoginStateNetworkError) {
    showFailureScackbar(
      context: context,
      height: height,
      title: "Connection Error",
      body: state.errorMessage,
    );
  } else if (state is LoginStateAuthenticationError) {
    showFailureScackbar(
      context: context,
      height: height,
      title: "Authentication Failed",
      body: state.errorMessage,
    );
  } else if (state is LoginStateValidationError) {
    showFailureScackbar(
      context: context,
      height: height,
      title: "Invalid Input",
      body: state.errorMessage,
    );
  } else if (state is LoginStateFailure) {
    showFailureScackbar(
      context: context,
      height: height,
      title: "Login Failed",
      body: state.errorMessage,
    );
  }
}

void _handleLoginSuccess(
  BuildContext context,
  double height,
  TextEditingController emailController,
  TextEditingController passwordController,
) {
  showSuccessSnackbar(
    context: context,
    height: height,
    title: "Login Successfull",
    body: "You have successfully logged in!",
  );
  emailController.clear();
  passwordController.clear();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) {
        context
            .read<NavigationBloc>()
            .add(NavigationTabChanged(NavigationTab.home));
        return DashBoardScreen();
      },
    ),
    (Route<dynamic> route) => false,
  );
}

Widget _buildLoginHeader(double height) {
  return Column(
    children: [
      SizedBox(height: height * 0.04),
      const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w800,
        ),
      ),
      CustomText(
        text: "Enter your credentials to access your account",
        fontSize: 15,
        FontFamily: 'roboto',
        fontWeight: FontWeight.w400,
      ),
      SizedBox(height: height * 0.01),
    ],
  );
}

Widget _buildEmailField(TextEditingController logEmailController) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: CustomText(text: "Email"),
        ),
      ),
      CustomTextField(
        controller: logEmailController,
        hintText: "Enter your email..",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Email is required";
          }
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    ],
  );
}

Widget _buildPasswordField(LoginState state, BuildContext context,
    TextEditingController logPasswordController) {
  bool isPasswordVisible = false;
  if (state is LoginInitial) {
    isPasswordVisible = state.isPasswordVisible;
  }

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: CustomText(text: "Password"),
        ),
      ),
      CustomTextField(
        controller: logPasswordController,
        obscureText: !isPasswordVisible,
        hintText: "Enter your password",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password is required";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
        suffixIcon: IconButton(
          onPressed: () {
            context.read<LoginBloc>().add(TogglePasswordVisibilityEvent());
          },
          icon: Icon(
            isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppTheme.darkTextColorSecondary,
          ),
        ),
      ),
    ],
  );
}

Widget _buildLoginButton(
    BuildContext context,
    GlobalKey<FormState> loginFormKey,
    TextEditingController logEmailController,
    TextEditingController logPasswordController) {
  return PrimaryButton(
    buttonColor: AppTheme.darkButtonPrimaryColor,
    label: "Login",
    ontap: () {
      if (loginFormKey.currentState!.validate()) {
        final String email = logEmailController.text.trim();
        final String password = logPasswordController.text.trim();
        log("Attempting login with email: $email and password: $password");
        BlocProvider.of<LoginBloc>(context).add(
          LoginRequestEvent(email: email, password: password),
        );
        logEmailController.clear();
        logPasswordController.clear();
      }
    },
  );
}

Widget _buildForgotPasswordLink(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        CupertinoPageRoute(builder: (context) => AddEmailScreen()),
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CustomText(
        text: "Forgot password?",
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
