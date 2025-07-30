 import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildEventTitle(Event event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: event.title,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 8),
        CustomText(
          text: "Coordinates",
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppTheme.darkIconColor,
        ),
      ],
    );
  }