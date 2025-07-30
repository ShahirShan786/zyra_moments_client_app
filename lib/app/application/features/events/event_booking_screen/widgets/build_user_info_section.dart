  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildUserInfoSection(double width, double height) {
    return Container(
      width: double.infinity,
      height: height * 0.1,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.darkBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Your Information",
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: height * 0.01),
          CustomText(
            text: "Please provide your details for the booking",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.darkTextLightColor,
          ),
        ],
      ),
    );
  }