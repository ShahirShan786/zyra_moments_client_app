import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/features/auth/widgets/login_widget/build_divider_with_text.dart';
import 'package:zyra_momments_app/application/features/auth/widgets/login_widget/build_google_sign_in_button.dart';
import 'package:zyra_momments_app/application/features/auth/widgets/login_widget/build_login_form.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.height,
    required GlobalKey<FormState> loginFormKey,
    required this.logEmailController,
    required this.logPasswordController,
    required this.width,
  }) : _loginFormKey = loginFormKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double height;
  final GlobalKey<FormState> _loginFormKey;
  final TextEditingController logEmailController;
  final TextEditingController logPasswordController;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          buildLoginForm(context, height, _loginFormKey, emailController,
              passwordController, logEmailController, logPasswordController),
          buildDividerWithText(),
          buildGoogleSignInButton(context, height, width),
        ],
      ),
    );
  }
}

// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
// import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
// import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
// import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';
// import 'package:zyra_momments_app/application/features/auth/login/bloc/login_bloc.dart';
// import 'package:zyra_momments_app/application/features/auth/sign_up/bloc/auth_sign_bloc.dart';
// import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
// import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
// import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';
// import 'package:zyra_momments_app/application/features/forgot_password/add_email_screen.dart';

// class LoginSection extends StatelessWidget {
//   const LoginSection({
//     super.key,
//     required this.emailController,
//     required this.passwordController,
//     required this.height,
//     required GlobalKey<FormState> loginFormKey,
//     required this.logEmailController,
//     required this.logPasswordController,
//     required this.width,
//   }) : _loginFormKey = loginFormKey;

//   final TextEditingController emailController;
//   final TextEditingController passwordController;
//   final double height;
//   final GlobalKey<FormState> _loginFormKey;
//   final TextEditingController logEmailController;
//   final TextEditingController logPasswordController;
//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Column(
//         children: [
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//               child: BlocConsumer<LoginBloc, LoginState>(
//                 listener: (context, state) {
//                   if (state is LoginStateSuccess) {
//                     showSuccessSnackbar(
//                         context: context,
//                         height: height,
//                         title: "Login Successfull",
//                         body: "You have successfully logged in!");
//                     emailController.clear();
//                     passwordController.clear();
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           context
//                               .read<NavigationBloc>()
//                               .add(NavigationTabChanged(NavigationTab.home));
//                           return DashBoardScreen();
//                         },
//                       ),
//                       (Route<dynamic> route) => false,
//                     );
//                   }else if (state is LoginStateNetworkError) {
//       showFailureScackbar(
//         context: context,
//         height: height,
//         title: "Connection Error",
//         body: state.errorMessage
//       );
//     } else if (state is LoginStateAuthenticationError) {
//       showFailureScackbar(
//         context: context,
//         height: height,
//         title: "Authentication Failed",
//         body: state.errorMessage
//       );
//     } else if (state is LoginStateValidationError) {
//       showFailureScackbar(
//         context: context,
//         height: height,
//         title: "Invalid Input",
//         body: state.errorMessage
//       );
//     } else if (state is LoginStateFailure) {
//       showFailureScackbar(
//         context: context,
//         height: height,
//         title: "Login Failed",
//         body: state.errorMessage
//       );
//     }
//                 },
//                 builder: (context, state) {
//                   return Container(
//                     width: double.infinity,
//                     height: height * 0.46,
//                     decoration: BoxDecoration(
//                         border: Border.all(color: AppTheme.darkBorderColor),
//                         borderRadius: BorderRadius.circular(8)),
//                     child: Form(
//                       key: _loginFormKey,
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: height * 0.02,
//                           ),
//                           Text(
//                             "Login",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.w800),
//                           ),
//                           CustomText(
//                             text:
//                                 "Enter your credentials to access your account",
//                             fontSize: 15,
//                             FontFamily: 'roboto',
//                             fontWeight: FontWeight.w400,
//                           ),
//                           SizedBox(
//                             height: height * 0.01,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 15),
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CustomText(
//                                   text: "Email",
//                                 )),
//                           ),
//                           CustomTextField(
//                             controller: logEmailController,
//                             hintText: "Enter your email..",
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Email is required";
//                               }
//                               final emailRegex =
//                                   RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                               if (!emailRegex.hasMatch(value)) {
//                                 return 'Please enter a valid email address';
//                               }
//                               return null;
//                             },
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 15),
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: CustomText(
//                                   text: "Password",
//                                 )),
//                           ),
//                           BlocBuilder<LoginBloc, LoginState>(
//                             builder: (context, state) {
//                               bool isPasswordVisible = false;
//                               if (state is LoginInitial) {
//                                 isPasswordVisible = state.isPasswordVisible;
//                               }
//                               return CustomTextField(
//                                 controller: logPasswordController,
//                                 obscureText: !isPasswordVisible,
//                                 hintText: "Enter your password",
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Password is required";
//                                   }
//                                   if (value.length < 6) {
//                                     return "Password must be at least 6 characters";
//                                   }
//                                   return null;
//                                 },
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     context
//                                         .read<LoginBloc>()
//                                         .add(TogglePasswordVisibilityEvent());
//                                   },
//                                   icon: Icon(
//                                     isPasswordVisible
//                                         ? Icons.visibility_outlined
//                                         : Icons.visibility_off_outlined,
//                                     color: AppTheme.darkTextColorSecondary,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           SizedBox(
//                             height: height * 0.02,
//                           ),
//                           PrimaryButton(
//                             label: "Login",
//                             ontap: () {
//                               if (_loginFormKey.currentState!.validate()) {
//                                 final String email =
//                                     logEmailController.text.trim();
//                                 final String password =
//                                     logPasswordController.text.trim();
//                                 log("Attempting login with email: $email and password: $password");
//                                 BlocProvider.of<LoginBloc>(context).add(
//                                     LoginRequestEvent(
//                                         email: email, password: password));

//                                 logEmailController.clear();
//                                 logPasswordController.clear();
//                               }
//                             },
//                           ),
//                           SizedBox(
//                             height: height * 0.01,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).push(CupertinoPageRoute(
//                                 builder: (context) => AddEmailScreen(),
//                               ));
//                             },
//                             child: CustomText(
//                               text: "Forgot password?",
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )),
//           SizedBox(
//             width: height * 0.01,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Divider(
//                     color: AppTheme.darkBorderColor,
//                     height: 1,
//                     thickness: 1,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8), // Add spacing
//                   child: CustomText(
//                     text: "OR Continue with",
//                     fontSize: 13,
//                   ),
//                 ),
//                 Expanded(
//                   child: Divider(
//                     color: AppTheme.darkBorderColor,
//                     height: 1,
//                     thickness: 1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           BlocListener<AuthSignBloc, AuthSignState>(
//               listener: (context, state) {
//                 if (state is AuthSignGoogleStateLoading) {
//                   showDialog(
//                       context: context,
//                       builder: (_) =>
//                           Center(child: CircularProgressIndicator()));
//                 } else if (state is AuthSignGoogleStateSuccess) {
//                   Navigator.of(context).push(CupertinoPageRoute(
//                     builder: (context) => DashBoardScreen(),
//                   ));

//                   // Navigate to home page
//                 } else if (state is AuthSignGoogleStateFailure) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.errorMessage)),
//                   );
//                 }
//               },
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//                 child: InkWell(
//                   onTap: () {
//                     context.read<AuthSignBloc>().add(RegisteWIthGoogleEvent());
//                   },
//                   child: Container(
//                       alignment: Alignment.center,
//                       width: double.infinity,
//                       height: height * 0.055,
//                       decoration: BoxDecoration(
//                           color: AppTheme.darkButtonPrimaryColor,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             'assets/svgs/google.svg',
//                             width: width * 0.05,
//                           ),
//                           SizedBox(
//                             width: width * 0.02,
//                           ),
//                           CustomText(
//                             text: "Sign in with Google",
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ],
//                       )),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
