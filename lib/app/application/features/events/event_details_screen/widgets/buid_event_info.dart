
  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildEventInfo(String createdDate, double width, double height , Event event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: height * 0.005,
      children: [
        const SizedBox(height: 8),
        _buildInfoRow(Icons.calendar_today_outlined, createdDate),
        _buildInfoRow(
          Icons.timer_outlined,
          "${event.startTime} - ${event.endTime}",
        ),
        _buildInfoRow(Icons.location_on, event.eventLocation),
        _buildInfoRow(
          Icons.confirmation_number_outlined,
          "${event.pricePerTicket} per ticket (${event.ticketLimit} tickets available)",
        ),
        _buildInfoRow(
          Icons.person_2_outlined,
          "Hosted by ${event.hostId.firstName} ${event.hostId.lastName}",
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 23, color: AppTheme.darkTextColorSecondary),
        const SizedBox(width: 8),
        Expanded(child: CustomText(text: text)),
      ],
    );
  }
