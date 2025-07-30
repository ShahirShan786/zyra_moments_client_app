import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

// ignore: must_be_immutable
class BenefitCard extends StatelessWidget {
  final content;
  bool animate;
  BenefitCard(
      {super.key,
      required this.width,
      required this.content,
      required this.animate});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        spacing: width * 0.04,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: width * 0.030,
            backgroundColor: AppTheme.darkTextColorPrymary,
            child: CircleAvatar(
              radius: width * 0.026,
              backgroundColor: AppTheme.darkPrimaryColor,
              child: Icon(
                Icons.check,
                color: AppTheme.darkTextColorPrymary,
                size: 13,
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              maxLines: 3,
              text: content,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
