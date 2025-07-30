
  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildDateTimeSection(DateTime date , TimeSlot time) {

  String formatTime(String timeStr) {
    final parsedTime = DateFormat("HH:mm").parse(timeStr);
    return DateFormat.jm().format(parsedTime);
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionHeader(icon: Icons.date_range_outlined, title: "Date and Time"),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppTheme.darkSecondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: _buildDetailItem(
                  label: "Date",
                  value: DateFormat("dd-MM-yyyy").format(date),
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  label: "Time",
                  value: "${formatTime(time.startTime)} - ${formatTime(time.endTime)}",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  

  Widget _buildDetailItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          color: AppTheme.darkTextLightColor,
          fontWeight: FontWeight.w500,
        ),
        CustomText(text: value, fontWeight: FontWeight.w500),
      ],
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