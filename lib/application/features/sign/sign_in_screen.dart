import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zyra_momments_app/application/config/dashboard_images.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.darkOnPrymaryColor,
        body: SafeArea(
          child: Column(
            children: [
              // Carousel and welcome text section
              SizedBox(
                width: double.infinity,
                height: height * 0.34, // Slightly reduced height
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: images,
                      options: CarouselOptions(
                        height: height * 0.5,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        autoPlayInterval: Duration(seconds: 10),
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.easeInOut,
                        autoPlay: true,
                      ),
                    ),
                     Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: height * 0.7,
                    color: Colors.black.withAlpha(100),
                  ),
                ),
                    Positioned(
                      top: height * 0.1,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            "Welcome back",
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: "amaranth",
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "We're glad to see you again!",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'open',
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 9),
              // Tab bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black,
                    indicatorAnimation: TabIndicatorAnimation.linear,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: Colors.white,
                    splashBorderRadius: BorderRadius.circular(15),
                    indicator: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    tabs: [
                      Tab(text: "Login"),
                      Tab(text: "Sign Up"),
                    ],
                  ),
                ),
              ),
              // Tab content - Expanded to fill remaining space
              Expanded(
                child: TabBarView(
                  children: [
                    // Login Tab
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            // Login Form Container
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.darkBorderColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                              child: Column(
                                children: [
                                  Text(
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
                                  SizedBox(height: 16),
                                  // Email Field
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                                      child: CustomText(text: "Email"),
                                    ),
                                  ),
                                  CustomTextField(hintText: "Enter your email.."),
                                  SizedBox(height: 12),
                                  // Password Field
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                                      child: CustomText(text: "Password"),
                                    ),
                                  ),
                                  CustomTextField(hintText: "Enter your password"),
                                  SizedBox(height: 24),
                                  // Login Button
                                  PrimaryButton(
                                    label: "Login",
                                    ontap: () {},
                                  ),
                                  SizedBox(height: 16),
                                  // Sign Up text
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: "Don't have an account?",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      SizedBox(width: width * 0.01),
                                      CustomText(
                                        text: "Sign Up",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            // OR divider
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppTheme.darkBorderColor,
                                    height: 1,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: CustomText(
                                    text: "OR Continue with",
                                    fontSize: 13,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: AppTheme.darkBorderColor,
                                    height: 1,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Google sign in button
                            InkWell(
                              onTap: () {},
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
                            SizedBox(height: 20), // Added bottom spacing
                          ],
                        ),
                      ),
                    ),
                    // Sign Up Tab (placeholder)
                    Center(
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "Sign Up Form (To Be Implemented)",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}