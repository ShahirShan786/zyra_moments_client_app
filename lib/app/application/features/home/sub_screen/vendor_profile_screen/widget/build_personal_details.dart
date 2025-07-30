import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class PersonalDetails extends StatelessWidget {
  final double height;
  final double width;
  final String phoneNumber;
  final String email;

  const PersonalDetails({
    super.key,
    required this.height,
    required this.width,
    required this.phoneNumber,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.03),
          _buildDetailRow(icon: Icons.call, text: phoneNumber),
          SizedBox(height: height * 0.04),
          _buildDetailRow(icon: Icons.email_rounded, text: email),
          SizedBox(height: height * 0.04),
          _buildDetailRow(icon: Icons.location_on, text: "Location not specified"),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.darkTextColorSecondary,
          size: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomText(
            text: text,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}