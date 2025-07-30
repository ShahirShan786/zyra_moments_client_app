  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/events/event_details_screen/event_details_screen.dart';
import 'package:zyra_momments_app/app/application/features/events/widgets/build_event_details.dart';
import 'package:zyra_momments_app/app/application/features/events/widgets/build_event_image.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';


Widget buildEventGridContainer(List<Event> events, double width, double height) {
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
        final event = events[index];
        final formattedDate = event.date != null
            ? DateFormat('dd-MM-yyyy').format(event.date)
            : 'N/A';
        final formattedTime = event.date != null
            ? DateFormat('hh:mm a').format(event.date)
            : 'N/A';
            
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventDetailsScreen(event: event),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.darkSecondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildEventImage(event, height),
                buildEventDetails(event, formattedDate, formattedTime, width, height),
              ],
            ),
          ),
        );
      },
    );
  }

 

 