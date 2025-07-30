import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/features/auth/sign_up/bloc/auth_sign_bloc.dart';
import 'package:zyra_momments_app/application/features/auth/widgets/carosal_section.dart';
import 'package:zyra_momments_app/application/features/auth/widgets/first_form_sign_section.dart';
import 'package:zyra_momments_app/application/features/auth/widgets/login_section.dart';
import 'package:zyra_momments_app/application/features/auth/widgets/second_sign_form_section.dart';
import 'package:zyra_momments_app/application/features/verification/verification_code_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController logEmailController = TextEditingController();
  final TextEditingController logPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final PageController _pageController = PageController();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  // int _currentPage = 0;

  void _nextPage() {
    if (_formKey1.currentState!.validate()) {
      context.read<AuthSignBloc>().add(FirstPageSubmitted(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phone: phoneController.text));
      _pageController.nextPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void registration() {
    if (_formKey2.currentState!.validate()) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => VerificationCodeScreen(
                email: emailController.text,
                password: passwordController.text,
              )));
    }
  }

  @override
  void dispose() {
    logEmailController.dispose();
    logPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.darkPrimaryColor,
        body: Column(
          children: [
            CarosalSection(height: height, width: width),
            SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: height * 0.05,
                decoration: BoxDecoration(
                    color: AppTheme.darkBlackColor,
                    borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppTheme.darkBlackColor,
                    dividerColor: AppTheme.darkBlackColor,
                    indicatorAnimation: TabIndicatorAnimation.linear,
                    unselectedLabelColor: AppTheme.darkTextColorPrymary,
                    splashBorderRadius: BorderRadius.circular(15),
                    indicator: BoxDecoration(
                        color: AppTheme.darkButtonPrimaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    tabs: [
                      Tab(
                        text: "Login",
                      ),
                      Tab(
                        text: "Sign Up",
                      )
                    ]),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: LoginSection(
                        emailController: emailController,
                        passwordController: passwordController,
                        height: height,
                        loginFormKey: _loginFormKey,
                        logEmailController: logEmailController,
                        logPasswordController: logPasswordController,
                        width: width),
                  ),
                  BlocConsumer<AuthSignBloc, AuthSignState>(
                    listener: (context, state) {
                      log("Current State: $state");
                      if (state is AuthSignStateSuccess) {
                        showSuccessSnackbar(
                            context: context,
                            height: height,
                            title: "Registration Successfull",
                            body:
                                "You have successfully Registered in. Pease login!");
                        Future.delayed(Duration(seconds: 4), () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => AuthScreen()));
                        });
                      } else if (state is AuthSignStateFailure) {
                        showFailureScackbar(
                            context: context,
                            height: height,
                            title: "Registration Failed",
                            body: state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      return SingleChildScrollView(
                          child: SizedBox(
                        height: height * 0.6,
                        child: PageView(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Form(
                                key: _formKey1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      FirstSignFormSection(
                                          height: height,
                                          firstNameController:
                                              firstNameController,
                                          lastNameController:
                                              lastNameController,
                                          phoneController: phoneController),
                                      SizedBox(
                                        width: height * 0.01,
                                      ),
                                      PrimaryButton(
                                          buttonColor:
                                              AppTheme.darkButtonPrimaryColor,
                                          label: "Next",
                                          ontap: _nextPage)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Form(
                                key: _formKey2,
                                child: Column(
                                  children: [
                                    SecondSignFromSection(
                                        height: height,
                                        emailController: emailController,
                                        passwordController: passwordController,
                                        confirmPasswordController:
                                            confirmPasswordController),
                                    SizedBox(
                                      width: height * 0.01,
                                    ),
                                    PrimaryButton(
                                        buttonColor:
                                            AppTheme.darkButtonPrimaryColor,
                                        label: "Register",
                                        ontap: registration)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
