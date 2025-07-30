 import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildPeopleSection(RId user ,  RId vendor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader(icon: Icons.person_2_outlined, title: "People"),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildPersonCard(
              title: "Client",
              name: "${user.firstName} ${user.lastName}",
              id:user.id,
            ),
            const SizedBox(width: 10),
            _buildPersonCard(
              title: "Vendor",
              name: "${vendor.firstName} ${vendor.lastName}",
              id: vendor.id,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonCard({required String title, required String name, required String id}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppTheme.darkSecondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              fontSize: 15,
              color: AppTheme.darkTextLightColor,
            ),
            CustomText(text: name, fontWeight: FontWeight.w500),
            CustomText(
              text: "id: $id",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppTheme.darkTextLightColor,
            ),
          ],
        ),
      ),
    );
  }

     Widget buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.darkTextColorSecondary),
        const SizedBox(width: 8),
        CustomText(
          text: title,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }