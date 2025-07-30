 import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildEventDetails(
    Event event,
    String formattedDate,
    String formattedTime,
    double width,
    double height,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height * 0.0026,
        children: [
          SizedBox(height: height * 0.001),
          CustomText(
            text: event.title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
            text: "Corporate",
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.darkTextLightColor,
          ),
          Row(
            children: [
              Column(
                spacing: height * 0.007,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                    color: AppTheme.darkTextColorSecondary,
                  ),
                  Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: AppTheme.darkTextColorSecondary,
                  ),
                  Icon(
                    Icons.location_on,
                    size: 15,
                    color: AppTheme.darkTextColorSecondary,
                  ),
                ],
              ),
              SizedBox(width: width * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: height * 0.004,
                children: [
                  CustomText(
                    text: formattedDate,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  CustomText(
                    text: formattedTime,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  CustomText(
                    text: event.eventLocation,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: double.infinity,
              height: height * 0.038,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppTheme.darkTextColorSecondary,
              ),
              alignment: Alignment.center,
              child: CustomText(
                text: "View Details",
                color: AppTheme.darkBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
