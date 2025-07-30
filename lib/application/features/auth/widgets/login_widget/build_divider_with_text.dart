import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildDividerWithText() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 18,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child:
              Divider(color: AppTheme.darkBorderColor, height: 1, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: CustomText(
            text: "OR Continue with",
            fontSize: 13,
          ),
        ),
        Expanded(
          child:
              Divider(color: AppTheme.darkBorderColor, height: 1, thickness: 1),
        ),
      ],
    ),
  );
}
