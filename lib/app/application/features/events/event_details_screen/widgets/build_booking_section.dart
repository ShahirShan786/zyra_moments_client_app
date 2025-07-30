  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/event_booking_screen.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';

Widget buildBookingSection(BuildContext context , double height, double width , Event event) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.darkBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBookingTitle(),
          const SizedBox(height: 10),
          _buildPriceRow(event),
          const SizedBox(height: 10),
          _buildBookNowButton(context , event),
        ],
      ),
    );
  }

  Widget _buildBookingTitle() {
    return CustomText(
      text: "Book Your Tickets",
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
  }

  Widget _buildPriceRow(Event event) {
    return Row(
      children: [
        CustomText(
          text: "Total Price : ",
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        CustomText(
          text: "₹${event.pricePerTicket}",
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildBookNowButton(BuildContext context , Event event) {
    return PrimaryButton(
      label: "Book Now",
      ontap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventBookingScreen(
              events:event,
              posterImage:event.posterImage!,
            ),
          ),
        );
      },
    );
  }
