  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildSummarySection(double height, Service service) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: double.infinity,
        height: height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.darkBorderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: height * 0.008,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.001),
              CustomText(
                text: "Summary",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: height * 0.01),
              _buildSummaryRow(service.serviceTitle, service.servicePrice.toDouble()),
              _buildSummaryRow("Platform Fee", 0.00),
              _buildSummaryRow("GST on Platform Fee", 0.00),
              Divider(
                color: AppTheme.darkBorderColor,
                thickness: 2,
              ),
              _buildSummaryRow("Total Amount", service.servicePrice.toDouble(), isTotal: true),
            ],
          ),
        ),
      ),
    );
  }


    Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          fontWeight: isTotal ? FontWeight.w500 : FontWeight.normal,
        ),
        CustomText(
          text: "₹ ${amount.toStringAsFixed(2)}",
          fontWeight: isTotal ? FontWeight.w500 : FontWeight.normal,
        ),
      ],
    );
  }