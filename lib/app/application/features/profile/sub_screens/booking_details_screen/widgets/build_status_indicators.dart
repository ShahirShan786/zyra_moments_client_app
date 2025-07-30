 import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildStatusIndicators(String status, String paymentSatus) {
    return Row(
      children: [
        _buildStatusContainer(
          status: status,
          icon: Icons.timer_outlined,
          text: paymentSatus == 'pending' ? 'Pending' : 'Succeeded',
        ),
        const SizedBox(width: 8),
        _buildStatusContainer(
          status: paymentSatus,
          icon: Icons.timer_outlined,
          text:paymentSatus == 'pending' ? 'Pending' : '₹ Succeeded',
        ),
      ],
    );
  }

  Widget _buildStatusContainer({
    required String status,
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: status == 'pending'
            ? Colors.amber.withAlpha(84)
            : Colors.green.withAlpha(84),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.darkTextColorSecondary, size: 15),
          const SizedBox(width: 4),
          CustomText(text: text, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
