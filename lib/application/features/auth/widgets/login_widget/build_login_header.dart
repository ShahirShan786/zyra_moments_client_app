

import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildLoginHeader(double height) {
    return Column(
      children: [
        SizedBox(height: height * 0.02),
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