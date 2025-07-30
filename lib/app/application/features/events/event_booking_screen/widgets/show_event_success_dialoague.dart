 import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/payment_success_screen/payment_success_screen.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

void showEventSuccessDialog(BuildContext context , Event events) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.darkSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSuccessIcon(),
              SizedBox(height: 16),
              _buildSuccessTitle(),
              SizedBox(height: 8),
              _buildSuccessMessage(),
              SizedBox(height: 20),
              _buildViewTicketButton(context, events ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 50,
      ),
    );
  }

  Widget _buildSuccessTitle() {
    return CustomText(
      text: "Payment Successful!",
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    );
  }

  Widget _buildSuccessMessage() {
    return CustomText(
      text: "Your payment has been processed successfully. Your ticket is confirmed!",
      fontSize: 14,
      color: AppTheme.darkTextLightColor,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildViewTicketButton(BuildContext context , Event events) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PaymentSuccessScreen(
                eventId: events.id,
                eventTitle: events.title,
                eventLocation: events.eventLocation,
                date: events.date,
                starTime: events.startTime,
                endTime: events.endTime,
                price: events.pricePerTicket,
                userFirstName: events.hostId.firstName,
                userLastName: events.hostId.lastName,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: CustomText(
          text: "View Ticket",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }