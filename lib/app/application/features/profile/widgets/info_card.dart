import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class InfoCard extends StatelessWidget {
  final String info;
  
  const InfoCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomText(text: ":"),
        CustomText(
          text: info,
          color: AppTheme.darkTextColorSecondary,
        ),
      ],
    );
  }
}