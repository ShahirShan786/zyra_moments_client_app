import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/data/models/host_event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.height,
    required this.width,
    required this.hostEvent,
    required this.date,
  });

  final double height;
  final double width;
  final Event hostEvent;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        height: height * 0.15,
        decoration: BoxDecoration(
            color: AppTheme.darkSecondaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            spacing: width * 0.025,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.22,
                height: height * 0.095,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: hostEvent.posterImage.isNotEmpty
                      ? Image.network(
                          hostEvent.posterImage,
                          width: width * 0.22,
                          height: height * 0.095,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null)
                              // ignore: curly_braces_in_flow_control_structures
                              return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[400],
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[400],
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: hostEvent.title,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: height * 0.004,
                  ),
                  SizedBox(
                    width: width * 0.62,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: width * 0.001,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: AppTheme.darkTextColorSecondary,
                              size: 15,
                            ),
                            CustomText(
                              text: date,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.darkTextLightColor,
                            ),
                          ],
                        ),
                        Row(
                          spacing: width * 0.01,
                          children: [
                            Icon(
                              Icons.timer,
                              color: AppTheme.darkTextColorSecondary,
                              size: 19,
                            ),
                            CustomText(
                              text:
                                  "${hostEvent.startTime} - ${hostEvent.endTime}",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.darkTextLightColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: width * 0.58,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: width * 0.01,
                          children: [
                            Icon(
                              Icons.confirmation_num_outlined,
                              color: AppTheme.darkTextColorSecondary,
                              size: 20,
                            ),
                            CustomText(
                              text: "₹ ${hostEvent.pricePerTicket}",
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkTextColorSecondary,
                            ),
                          ],
                        ),
                        Container(
                          width: width * 0.23,
                          height: height * 0.04,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(37, 75, 223, 77),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: CustomText(
                            text: "Active",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
