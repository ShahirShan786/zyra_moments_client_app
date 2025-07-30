import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/features/auth/sign_up/bloc/auth_sign_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';

Widget buildGoogleSignInButton(
    BuildContext context, double height, double width) {
  return BlocListener<AuthSignBloc, AuthSignState>(
    listener: (context, state) => _handleGoogleSignInState(context, state , height),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: InkWell(
        onTap: () {
          context.read<AuthSignBloc>().add(RegisteWIthGoogleEvent());
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: height * 0.055,
          decoration: BoxDecoration(
            color: AppTheme.darkButtonPrimaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/google.svg',
                width: width * 0.05,
              ),
              SizedBox(width: width * 0.02),
              CustomText(
                text: "Sign in with Google",
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _handleGoogleSignInState(BuildContext context, AuthSignState state , double height) {
  if (state is AuthSignGoogleStateLoading) {
    showDialog(
      context: context,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );
  } else if (state is AuthSignGoogleStateSuccess) {
    showSuccessSnackbar(
    context: context,
    height: height,
    title: "Login Successfull",
    body: "You have successfully logged in!",
  );

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
  } else if (state is AuthSignGoogleStateFailure) {
    log("Erro is : ${state.errorMessage}");
    ScaffoldMessenger.of(context).showSnackBar(
      
      SnackBar(
        backgroundColor: Colors.purple,
        content: Text(state.errorMessage)),
    );
  }
}
