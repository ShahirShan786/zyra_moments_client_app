
  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildPaymentSection(BuildContext context , String paymentId , String paymentSatus , int totalPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(icon: Icons.currency_rupee, title: "Payment"),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppTheme.darkSecondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPaymentDetailRow(
                label: "Payment iD",
                value: paymentId,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              _buildPaymentDetailRow(
                label: "Status",
                value: paymentSatus,
              ),
              Divider(
                color: AppTheme.darkBorderColor,
                thickness: 2,
              ),
              _buildPaymentDetailRow(
                label: "Total Amount",
                value: "₹$totalPrice.00",
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetailRow({
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            color: AppTheme.darkTextLightColor,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            text: value,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            fontSize: isTotal ? 22 : 16,
          ),
        ],
      ),
    );
  }

     Widget _buildSectionHeader({required IconData icon, required String title}) {
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