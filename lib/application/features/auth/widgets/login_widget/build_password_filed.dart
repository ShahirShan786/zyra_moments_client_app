  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';
import 'package:zyra_momments_app/application/features/auth/login/bloc/login_bloc.dart';

Widget buildPasswordField( LoginState state , BuildContext context , TextEditingController logPasswordController) {
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