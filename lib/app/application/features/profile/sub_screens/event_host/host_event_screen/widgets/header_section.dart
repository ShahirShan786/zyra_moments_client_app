import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class HeaderSection extends StatelessWidget {
  final String firstName;
  final String lastName;
  const HeaderSection({
    super.key,
    required this.width,
    required this.firstName,
    required this.lastName,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "EventFlow",
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: "Manage your events effortlessly",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: width * 0.040),
          child: CircleAvatar(
            radius: width * 0.080,
            backgroundColor: AppTheme.darkSecondaryColor,
            child: Center(
              child: CustomText(
                text:
                    "${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}",
                fontSize: 17,
                FontFamily: 'amaranth',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
