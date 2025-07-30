  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildServiceInfoSection(ServiceDetails service) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(icon: Icons.info_outline, title: "Service Info"),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppTheme.darkSecondaryColor,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: service.serviceTitle,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 8),
              CustomText(
                maxLines: null,
                text: service.serviceDescription,
                fontSize: 15,
                color: AppTheme.darkTextLightColor,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 20),
              _buildServiceDetailsRow(service),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDetailsRow(ServiceDetails service) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem(
                label: "Duration",
                value: "${service.serviceDuration} hours",
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                label: "Additional Hour Price",
                value: "₹${service.additionalHoursPrice}.00",
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem(label: "Base Price", value: "₹7000.00"),
              const SizedBox(height: 16),
              _buildDetailItem(
                label: "Total Price",
                value: "₹${service.servicePrice}.00",
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