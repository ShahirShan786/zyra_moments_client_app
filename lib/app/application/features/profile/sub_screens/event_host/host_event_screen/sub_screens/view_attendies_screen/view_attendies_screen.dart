import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/host_event_details_screen/bloc/host_request_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class ViewAttendiesScreen extends StatelessWidget {
  final String eventId;

  const ViewAttendiesScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) =>
          HostRequestBloc()..add(AttendiesDetailsRequest(eventId: eventId)),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<HostRequestBloc, HostRequestState>(
            builder: (context, state) {
              if (state is AttendiesDataLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AttendiesDataFailure) {
                return Center(child: CustomText(text: state.errorMessage));
              } else if (state is AttendiesDataLoaded) {
                final eventData = state.attendiesData;
                final attendiesData = state.attendiesData;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: eventData.title,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "Attendence Overview",
                        fontSize: 18,
                        color: AppTheme.darkTextLightColor,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        width: double.infinity,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                          color: AppTheme.darkSecondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  color: AppTheme.darkIconColor),
                              SizedBox(width: width * 0.03),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomText(
                                    text: "Date",
                                    fontSize: 18,
                                    color: AppTheme.darkTextLightColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  CustomText(
                                    text: DateFormat('dd-MMM-yyyy')
                                        .format(eventData.date),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.44,
                            height: height * 0.1,
                            decoration: BoxDecoration(
                              color: AppTheme.darkSecondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.people_alt_outlined,
                                      color: AppTheme.darkIconColor),
                                  SizedBox(width: width * 0.03),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomText(
                                        text: "Total tickets",
                                        fontSize: 18,
                                        color: AppTheme.darkTextLightColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      CustomText(
                                        text: eventData.totalTickets.toString(),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.44,
                            height: height * 0.1,
                            decoration: BoxDecoration(
                              color: AppTheme.darkSecondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle_outlined,
                                      color: AppTheme.darkIconColor),
                                  SizedBox(width: width * 0.03),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomText(
                                        text: "Scanned",
                                        fontSize: 18,
                                        color: AppTheme.darkTextLightColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      CustomText(
                                        text:
                                            eventData.scannedTickets.toString(),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      CustomText(
                        text: "Attendies",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "List of all attendies for ${eventData.title}",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: attendiesData.attendance.length,
                        itemBuilder: (context, index) {
                          final attender = attendiesData.attendance[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              width: double.infinity,
                              height: height * 0.23,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.darkSecondaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "Name",
                                        fontSize: 16,
                                        color: AppTheme.darkTextLightColor,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.05,
                                          vertical: height * 0.005,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.darkPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: CustomText(text: "Used"),
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    text:
                                        "${attender.firstName} ${attender.lastName}",
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: height * 0.01),
                                  CustomText(
                                    text: "Email",
                                    color: AppTheme.darkTextLightColor,
                                    fontSize: 16,
                                  ),
                                  CustomText(
                                    text: attender.email,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: height * 0.01),
                                  CustomText(
                                    text: "Ticket ID",
                                    color: AppTheme.darkTextLightColor,
                                    fontSize: 16,
                                  ),
                                  CustomText(
                                    text: attender.ticketId,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
