import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Booking Details",
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        CustomText(
          text: "Booking id : dsfghiu23sdfhkjsdfh",
          color: AppTheme.darkIconColor,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }