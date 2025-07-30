import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';
import 'package:zyra_momments_app/application/features/auth/sign_up/bloc/auth_sign_bloc.dart';

class SecondSignFromSection extends StatelessWidget {
  const SecondSignFromSection({
    super.key,
    required this.height,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final double height;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Container(
        width: double.infinity,
        height: height * 0.49,
        decoration: BoxDecoration(
            border: Border.all(color: AppTheme.darkBorderColor),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            CustomText(
              text: "Enter your credentials to access your account",
              fontSize: 15,
              FontFamily: 'roboto',
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Email",
                  )),
            ),
            CustomTextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter your Email",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email cannot be empty';
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Password",
                  )),
            ),
            BlocBuilder<AuthSignBloc, AuthSignState>(
              builder: (context, state) {
                bool isPasswordVisible = false;
                if (state is AuthSignInitial) {
                  isPasswordVisible = state.isPasswordVisible;
                }
                return CustomTextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  hintText: "Enter your password",
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      context
                          .read<AuthSignBloc>()
                          .add(ToggleSignPasswordVisibilityEvent());
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.darkTextColorSecondary,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Confirm password",
                  )),
            ),
            BlocBuilder<AuthSignBloc, AuthSignState>(
              builder: (context, state) {
                bool isPasswordVisible = false;
                if (state is AuthSignInitial) {
                  isPasswordVisible = state.isPasswordVisible;
                }
                return CustomTextField(
                  controller: confirmPasswordController,
                  obscureText: !isPasswordVisible,
                  hintText: "Enter password again",
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      context
                          .read<AuthSignBloc>()
                          .add(ToggleSignPasswordVisibilityEvent());
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.darkTextColorSecondary,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              height: height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
