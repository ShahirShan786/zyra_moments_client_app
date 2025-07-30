import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/qr_scanning_button/scanning_button.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/bloc/host_event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/add_host_event_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/host_event_details_screen/host_event_details_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/widgets/button_card.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/widgets/event_card.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/widgets/header_section.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class HostEventScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  const HostEventScreen(this.firstName, this.lastName, {super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => HostEventBloc()..add(GetHostEventListRequest()),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                spacing: height * 0.005,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.040,
                  ),
                  HeaderSection(
                    width: width,
                    firstName: firstName,
                    lastName: lastName,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Button_Card(
                    height: height,
                    width: width,
                    title: "Create an Event",
                    content: "Set up a new event and invite\nattendees",
                    leadingIcon: Icons.add,
                    buttonColors: [
                      Color(0xFF6A85FF),
                      Color.fromARGB(206, 193, 106, 177)
                    ],
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddHostEventScreen())),
                  ),
                  Button_Card(
                    height: height,
                    width: width,
                    title: "Track Attendees",
                    content: "monitor attendance and\nengagement",
                    leadingIcon: Icons.people_outlined,
                    buttonColors: [
                      Color.fromARGB(206, 193, 106, 177),
                      Color(0xFF6A85FF)
                    ],
                    onTap: () => showQrScanOptions(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Your Events",
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        BlocBuilder<HostEventBloc, HostEventState>(
                          builder: (context, state) {
                            if (state is GetHostEventListLoadingState) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is GetHostEventFailureState) {
                              return Center(
                                child: CustomText(text: state.errorMessage),
                              );
                            } else if (state is GetHostEventListSuccessState) {
                              return ListView.builder(
                                itemCount: state.hostEventList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final hostEvent = state.hostEventList[index];
                                  final date = DateFormat("dd/MMM/yyyy")
                                      .format(hostEvent.date);
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HostEventDetailsScreen(
                                            event: hostEvent,
                                          ),
                                        )),
                                    child: EventCard(
                                        height: height,
                                        width: width,
                                        hostEvent: hostEvent,
                                        date: date),
                                  );
                                },
                              );
                            }
                            return SizedBox();
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
