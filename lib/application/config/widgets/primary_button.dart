import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback ontap;
  final Color? buttonColor;
  final Color? buttonTextColor; // Marked as final for immutability

  const PrimaryButton({
    super.key,
    required this.label,
    required this.ontap,
    this.buttonColor,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: InkWell(
        onTap: ontap, // Directly assign the function
        borderRadius: BorderRadius.circular(8), // Added ripple effect
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.055,
          decoration: BoxDecoration(
            color: buttonColor ?? AppTheme.darkTextColorSecondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomText(
            text: label,
            fontSize: 17,
            color: buttonTextColor ?? AppTheme.darkBlackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
