
import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class FeatureBox extends StatelessWidget {
  final String label;
  final String body;

  const FeatureBox({
    super.key,
    required this.label,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 60,
      decoration: BoxDecoration(
        color: AppTheme.darkSecondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: label,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
            textAlign: TextAlign.center,
            fontSize: 12,
            color: AppTheme.darkTextLightColor,
            fontWeight: FontWeight.w400,
            text: body,
          ),
        ],
      ),
    );
  }
}

