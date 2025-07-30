 import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildEventBookingCard(double width, double height, String hostingDate , Event events) {
    return Container(
      width: double.infinity,
      height: height * 0.31,
      decoration: BoxDecoration(
        color: AppTheme.darkSecondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            _buildEventHeader(width, height, hostingDate ,events ),
            SizedBox(height: height * 0.015),
            _buildTicketSelectionCard(width, height  , events),
          ],
        ),
      ),
    );
  }

  Widget _buildEventHeader(double width, double height, String hostingDate , Event events) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: width * 0.02,
      children: [
        _buildEventPoster(width, height , events),
        _buildEventDetails(width,  hostingDate , events),
      ],
    );
  }

  Widget _buildEventPoster(double width, double height , Event events) {
    return Container(
      width: width * 0.45,
      height: height * 0.13,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: events.posterImage!.isNotEmpty
            ? _buildNetworkImage(height ,events)
            : _buildPlaceholderImage(height),
      ),
    );
  }

  Widget _buildNetworkImage(double height , Event events) {
    return Image.network(
      events.posterImage!,
      fit: BoxFit.cover,
      height: height * 0.30,
      width: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildImageShimmer(height);
      },
      errorBuilder: (_, __, ___) => _buildErrorImage(height),
    );
  }

  Widget _buildImageShimmer(double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height * 0.30,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _buildErrorImage(double height) {
    return Container(
      height: height * 0.15,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.error),
    );
  }

  Widget _buildPlaceholderImage(double height) {
    return Container(
      height: height * 0.15,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported),
    );
  }

  Widget _buildEventDetails(double width, String hostingDate , Event events) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: events.title,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text: "Corporate",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.darkTextLightColor,
        ),
        _buildDetailRow(
          Icons.calendar_today_outlined,
          hostingDate,
          width,
        ),
        _buildDetailRow(
          Icons.timer_outlined,
          "${events.startTime} - ${events.endTime}",
          width,
        ),
        _buildDetailRow(
          Icons.location_on_outlined,
          events.eventLocation,
          width,
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String text, double width) {
    return Row(
      spacing: width * 0.02,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.darkTextColorSecondary,
        ),
        CustomText(text: text),
      ],
    );
  }

  Widget _buildTicketSelectionCard(double width, double height , Event events) {
    return Container(
      width: double.infinity,
      height: height * 0.14,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.darkPrimaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.darkBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Select Tickets",
            fontSize: 18,
          ),
          CustomText(
            text: "Choose the number of tickets you want to purchase",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.darkTextLightColor,
          ),
          Spacer(),
          _buildTicketPriceRow(events),
        ],
      ),
    );
  }

  Widget _buildTicketPriceRow(Event events) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CustomText(
              text: "Standard Ticket",
              fontSize: 18,
            ),
            CustomText(
              text: "Access to the event",
              fontWeight: FontWeight.w500,
              color: AppTheme.darkTextLightColor,
              fontSize: 14,
            ),
          ],
        ),
        CustomText(
          text: "₹ ${events.pricePerTicket}",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
