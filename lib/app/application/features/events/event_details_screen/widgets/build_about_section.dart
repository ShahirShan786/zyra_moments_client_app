  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildAboutSection(
    double height,
    String hostingDate,
    dynamic user,
    double width,
    Event event
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.darkBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("About The Event"),
          _subText("Registration Fee", "₹${event.pricePerTicket}"),
          _subText("Date", hostingDate),
          _subText("Venue", event.eventLocation),
          _subText("Contact", ""),
          _contactRow(Icons.phone, user.phoneNumber, width),
          _contactRow(Icons.mail_rounded, user.email, width),
          const SizedBox(height: 5),
          _subText("Host Information", ""),
          _buildHostDescription(user),
        ],
      ),
    );
  }

  Widget _buildHostDescription(dynamic user) {
    return CustomText(
      text:
          "${user.firstName} ${user.lastName} is organizing this event. For any queries, please contact them directly.",
      maxLines: 3,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppTheme.darkTextLightColor,
    );
  }

  Widget _sectionTitle(String title) {
    return CustomText(
      text: title,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _subText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        if (value.isNotEmpty)
          CustomText(
            text: value,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppTheme.darkTextLightColor,
          ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _contactRow(IconData icon, String text, double width) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.darkTextLightColor, size: width * 0.045),
        const SizedBox(width: 8),
        CustomText(
          text: text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.darkTextLightColor,
        ),
      ],
    );
  }