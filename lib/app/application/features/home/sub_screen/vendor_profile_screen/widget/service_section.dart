import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';


import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class ServicesSection extends StatelessWidget {
  final List<Service> services;
  final double height;
  final double width;

  const ServicesSection({
    super.key,
    required this.services,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return services.isEmpty
        ? Center(child: CustomText(text: "No services available"))
        : ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Card(
                color: Colors.transparent,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: service.serviceTitle,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: service.serviceDescription,
                        fontSize: 14,
                      ),
                      const SizedBox(height: 8),
                      _buildServiceMetaRow(service),
                      SizedBox(height: height * 0.02),
                       Divider(thickness: 2, color: AppTheme.darkBorderColor),
                      SizedBox(height: height * 0.01),
                      _buildSectionTitle("Available Dates:"),
                      SizedBox(height: height * 0.02),
                      _buildAvailableDatesGrid(service),
                      SizedBox(height: height * 0.02),
                       Divider(thickness: 2, color: AppTheme.darkBorderColor),
                      SizedBox(height: height * 0.01),
                      _buildSectionTitle("Cancellation policy:"),
                      SizedBox(height: height * 0.02),
                      ..._buildPolicyList(service.cancellationPolicies),
                      SizedBox(height: height * 0.02),
                       Divider(thickness: 2, color: AppTheme.darkBorderColor),
                      SizedBox(height: height * 0.01),
                      _buildSectionTitle("Terms And Conditions:"),
                      SizedBox(height: height * 0.02),
                      ..._buildPolicyList(service.termsAndConditions),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildServiceMetaRow(Service service) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.work_history_outlined,
                size: 17,
                color: AppTheme.darkTextColorSecondary,
              ),
              SizedBox(width: 5),
              CustomText(
                text: "Experience: ${service.yearsOfExperience} years",
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 17,
                color: AppTheme.darkTextColorSecondary,
              ),
              SizedBox(width: 5),
              CustomText(
                text: "Duration: ${service.serviceDuration} hours",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CustomText(
      text: title,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  Widget _buildAvailableDatesGrid(Service service) {
    if (service.availableDates.isEmpty) {
      return CustomText(
        text: "No available dates",
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );
    }

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
        crossAxisCount: 2,
      ),
      itemCount: service.availableDates.length,
      itemBuilder: (context, dateIndex) {
        final date = service.availableDates[dateIndex];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.darkBorderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.darkTextColorSecondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomText(
                      text: DateFormat("dd-MM-yyyy").format(date.date),
                      color: AppTheme.darkBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  if (date.timeSlots.isNotEmpty)
                    ...date.timeSlots.map((slot) => CustomText(
                          text: "${slot.startTime} - ${slot.endTime} (Capacity: ${slot.capacity})",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ))
                  else
                    CustomText(
                      text: "No time slots available",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildPolicyList(List<String> policies) {
    return policies.map((policy) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.radio_button_on_rounded,
                  size: 15,
                  color: AppTheme.darkTextColorSecondary,
                ),
              ),
              SizedBox(width: width * 0.01),
              Expanded(
                child: CustomText(
                  text: policy,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        )).toList();
  }
}