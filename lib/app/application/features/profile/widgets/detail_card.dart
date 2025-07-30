import 'package:flutter/widgets.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class DetailCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String label;

  const DetailCard({
    super.key,
    required this.width,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.darkIconColor,
          size: width * 0.048,
        ),
        SizedBox(width: width * 0.01),
        CustomText(
          text: label,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
