
import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/widgets/build_payment_section.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildOrderSummarySection(double width, double height , Event events , BuildContext context) {
    return Container(
      width: double.infinity,
      height: height * 0.41,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.darkBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Order Summary",
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: height * 0.02),
          _buildOrderItem("1 ticket × ₹${events.pricePerTicket}", "₹${events.pricePerTicket}"),
          _buildOrderItem("Service ", "₹0"),
          SizedBox(height: height * 0.01),
          Divider(
            color: AppTheme.darkTextLightColor,
            thickness: 2,
          ),
          SizedBox(height: height * 0.01),
          _buildOrderItem("Total ", "₹${events.pricePerTicket}", isBold: true),
          SizedBox(height: height * 0.01),
          _buildBulletPoint("All prices are inclusive of taxes" , context),
          SizedBox(height: height * 0.001),
          _buildBulletPoint("Tickets are non-refundable" , context),
          _buildBulletPoint("Tickets are valid only for the date and time mentioned" , context),
          _buildBulletPoint("Each ticket admits one person only" , context),
          SizedBox(height: height * 0.02),
          buildPaymentSection(width, height , events),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String label, String value, {bool isBold = false}) {
    return Row(
      children: [
        CustomText(
          text: label,
          fontSize: 17,
          color: AppTheme.darkTextLightColor,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        ),
        Spacer(),
        CustomText(
          text: value,
          fontSize: 17,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text , BuildContext context){
    final width = MediaQuery.of(context).size.width;
    return Row(
      spacing: width * 0.02,
      children: [
        CircleAvatar(
          radius: width * 0.01,
          backgroundColor: AppTheme.darkTextColorSecondary,
        ),
        CustomText(
          text: text,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  


  
