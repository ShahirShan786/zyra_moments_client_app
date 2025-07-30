import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';


// ignore: must_be_immutable
class TileInfoCard extends StatelessWidget {
  IconData leadingIcon;
  String label;
  IconData trailingIcon;
  TileInfoCard(
      {super.key,
      required this.leadingIcon,
      required this.label,
      required this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppTheme.darkSecondaryColor,
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: AppTheme.darkTextColor,
        ),
        title: CustomText(
          text: label,
        ),
        trailing: Icon(
          trailingIcon,
          color: AppTheme.darkTextColor,
        ),
      ),
    );
  }
}
