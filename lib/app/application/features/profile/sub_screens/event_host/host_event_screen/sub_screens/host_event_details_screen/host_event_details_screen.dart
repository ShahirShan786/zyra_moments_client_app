import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/host_event_details_screen/bloc/host_request_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/view_attendies_screen/view_attendies_screen.dart';
import 'package:zyra_momments_app/app/data/models/host_event_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';

class HostEventDetailsScreen extends StatelessWidget {
  final Event event;
  const HostEventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => HostRequestBloc(),
      child: BlocListener<HostRequestBloc, HostRequestState>(
        listener: (context, state) {
          if (state is HostRequestSuccess) {
            showSuccessSnackbar(
                context: context,
                height: height,
                title: "Request Sent Successfully",
                body: "Fund release request sent successfully!");
          } else if (state is HostRequestFailure) {
            showFailureScackbar(
                context: context,
                height: height,
                title: "Request Failed",
                body: state.errorMessage);
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.30,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    event.posterImage,
                    width: double.infinity,
                    height: height * 0.30,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: AppTheme.darkTextColorSecondary,
                          value: loadingProgress.expectedTotalBytes != null
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: height * 0.012,
                  children: [
                    _aboutEvent(height, width, event),
                    Container(
                      width: double.infinity,
                      height: height * 0.15,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.darkBorderColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        spacing: height * 0.01,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Hosted by",
                            fontSize: 18,
                          ),
                          Row(
                            spacing: width * 0.05,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: width * 0.08,
                                backgroundColor: AppTheme.darkSecondaryColor,
                                child: Center(
                                  child: CustomText(text: "AA"),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        "${event.host.firstName} ${event.host.lastName}",
                                    fontSize: 17,
                                  ),
                                  CustomText(
                                    text: event.host.email,
                                    fontSize: 17,
                                  ),
                                  CustomText(
                                    text: event.host.phoneNumber,
                                    fontSize: 17,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: height * 0.18,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.darkBorderColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        spacing: height * 0.01,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Ticket Information",
                            fontSize: 18,
                          ),
                          Row(
                            spacing: width * 0.05,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.currency_rupee_outlined,
                                color: AppTheme.darkTextColorSecondary,
                                size: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        "₹${event.pricePerTicket}.00 per ticket",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    text: "Premium event pricing",
                                    fontSize: 16,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            spacing: width * 0.05,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.confirmation_num_outlined,
                                color: AppTheme.darkTextColorSecondary,
                                size: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        "${event.ticketLimit} tickets available",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  CustomText(
                                    text: "Limited availability",
                                    fontSize: 16,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    PrimaryButton(
                        label: "View Attendees",
                        ontap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewAttendiesScreen(
                                    eventId: event.id,
                                  )));
                        }),
                    BlocBuilder<HostRequestBloc, HostRequestState>(
                      builder: (context, state) {
                        return PrimaryButton(
                          label: state is HostRequestLoading
                              ? "Sending..."
                              : "Create Fund Release Request",
                          ontap: state is HostRequestLoading
                              ? () {} // Empty function instead of null
                              : () => _showModernBottomSheet(
                                    context: context,
                                    eventId: event.id,
                                    hostRequestBloc:
                                        context.read<HostRequestBloc>(),
                                  ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _aboutEvent(double height, double width, Event event) {
    return Container(
      width: double.infinity,
      height: height * 0.19,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.darkBorderColor),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: height * 0.005,
        children: [
          CustomText(
            text: event.title,
            fontSize: 18,
          ),
          CustomText(
            text: event.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            fontSize: 14,
            color: AppTheme.darkTextLightColor,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: height * 0.008,
                children: [
                  CustomText(
                    text: "Date and Time",
                    fontSize: 18,
                  ),
                  Row(
                    spacing: width * 0.01,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: AppTheme.darkIconColor,
                        size: 18,
                      ),
                      CustomText(
                        text: DateFormat('dd/MMM/yyyy').format(event.date),
                        color: AppTheme.darkIconColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  Row(
                    spacing: width * 0.01,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: AppTheme.darkIconColor,
                        size: 18,
                      ),
                      CustomText(
                        text: "${event.startTime} - ${event.endTime}",
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkIconColor,
                        fontSize: 14,
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: height * 0.008,
                  children: [
                    CustomText(
                      text: "Location",
                      fontSize: 18,
                    ),
                    Row(
                      spacing: width * 0.01,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppTheme.darkIconColor,
                          size: 18,
                        ),
                        CustomText(
                          text: event.eventLocation,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppTheme.darkIconColor,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _showModernBottomSheet({
    required BuildContext context,
    required String eventId,
    required HostRequestBloc hostRequestBloc,
  }) {
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: hostRequestBloc,
          child: BlocListener<HostRequestBloc, HostRequestState>(
            listener: (context, state) {
              if (state is HostRequestSuccess || state is HostRequestFailure) {
                Navigator.pop(bottomSheetContext); // Close bottom sheet
              }
            },
            child: Padding(
              padding: MediaQuery.of(bottomSheetContext).viewInsets,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Create Fund Release Request",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        text: "Message To Admin",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: const TextStyle(color: Colors.white60),
                          filled: true,
                          fillColor: AppTheme.darkTextFormFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Message cannot be empty';
                          } else if (value.trim().length < 5) {
                            return 'Message must be at least 5 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<HostRequestBloc, HostRequestState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            label: state is HostRequestLoading
                                ? "Sending..."
                                : "Send",
                            ontap: state is HostRequestLoading
                                ? () {} // Empty function instead of null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      hostRequestBloc.add(
                                        HostFundRequest(
                                          eventId: eventId,
                                          message:
                                              messageController.text.trim(),
                                        ),
                                      );
                                    }
                                  },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      messageController.dispose();
    });
  }
}
