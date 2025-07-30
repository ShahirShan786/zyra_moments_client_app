 import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/event_details_screen.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart' show CustomText;

Widget buildEventGrid(List<Event> events , BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 6,
        childAspectRatio: 0.67,
        crossAxisCount: 2,
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventCard(events[index], width, height , context);
      },
    );
  }

  Widget _buildEventCard(Event event, double width, double height , BuildContext context) {
    // ignore: unnecessary_null_comparison
    final formattedDate = event.date != null
        ? DateFormat('dd-MM-yyyy').format(event.date)
        : 'N/A';
    final formattedTime =
        // ignore: unnecessary_null_comparison
        event.date != null ? DateFormat('hh:mm a').format(event.date) : 'N/A';

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => EventDetailsScreen(event: event)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkSecondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventImage(event, height),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: height * 0.006,
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
                  _buildEventDetailsRow(
                      formattedDate, formattedTime, event, width, height),
                  SizedBox(height: height * 0.03),
                  _buildViewDetailsButton(height),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventImage(Event event, double height) {
    return SizedBox(
      width: double.infinity,
      height: height * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: event.posterImage != null && event.posterImage!.isNotEmpty
            ? Image.network(
                event.posterImage!,
                fit: BoxFit.cover,
                height: height * 0.15,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: height * 0.15,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(Icons.error),
                  );
                },
              )
            : Container(
                height: height * 0.15,
                width: double.infinity,
                color: Colors.grey[300],
                child: Icon(Icons.image_not_supported),
              ),
      ),
    );
  }

  Widget _buildEventDetailsRow(String formattedDate, String formattedTime,
      Event event, double width, double height) {
    return Row(
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
    );
  }

    Widget _buildViewDetailsButton(double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: double.infinity,
        height: height * 0.08,
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
    );
  }
