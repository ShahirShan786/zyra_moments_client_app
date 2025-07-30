import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/payment_success_screen/bloc/payment_bloc_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/core/api/save_and_share_pdf.dart';
import 'package:zyra_momments_app/application/core/api/save_tickets_to_downloads.dart';
import 'package:zyra_momments_app/application/features/dashboard/dashboard_screen.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_bloc.dart';
import 'package:zyra_momments_app/application/features/dashboard/navigation/bloc/navigation_tab.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String eventId;
  final String eventTitle;
  final String eventLocation;
  final DateTime date;
  final String starTime;
  final String endTime;
  final int price;
  final String userFirstName;
  final String userLastName;
  const PaymentSuccessScreen(
      {super.key,
      required this.eventId,
      required this.eventTitle,
      required this.eventLocation,
      required this.date,
      required this.price,
      required this.starTime,
      required this.endTime, required this.userFirstName, required this.userLastName});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          PaymentBlocBloc()..add(GetTicketDetailsReqeust(eventId: eventId)),
      child: Scaffold(
        // backgroundColor: AppTheme.darkSecondaryColor,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height * 0.3,
                // color: Colors.blueAccent,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: LottieBuilder.asset(
                        "assets/lottie/success.json",
                        height: height * 0.35,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.9),
                      child: CustomText(
                        text: "Booking Confirmed!",
                        fontSize: 35,
                        FontFamily: "roboto",
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: width * 0.01,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  CustomText(
                    text: "Your ticket has been booked successfully",
                    color: Colors.green,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DottedBorder(
                  options: RectDottedBorderOptions(
                    color: AppTheme.darkBorderColor,
                    strokeWidth: 1,
                    dashPattern: [6, 6],
                  ),
                  child: BlocBuilder<PaymentBlocBloc, PaymentBlocState>(
                    builder: (context, state) {
                      if (state is TicketDetailsLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TicketDetailsFailureState) {
                        return CustomText(text: state.errorMessage);
                      } else if (state is TicketDetailsSuccessState) {
                        final ticket = state.ticketDetails.ticket;
                        final qrCodeImage = state.ticketDetails.qrCodeImage;
                        return Container(
                          width: double.infinity,
                          height: height * 0.5,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            spacing: height * 0.005,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: eventTitle,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                              Row(
                                spacing: width * 0.02,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppTheme.darkIconColor,
                                    size: width * 0.05,
                                  ),
                                  CustomText(
                                    text:
                                        DateFormat('dd-MMM-yyyy').format(date),
                                    color: AppTheme.darkIconColor,
                                    fontSize: 15,
                                  )
                                ],
                              ),
                              Row(
                                spacing: width * 0.02,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: AppTheme.darkIconColor,
                                    size: width * 0.05,
                                  ),
                                  CustomText(
                                    text: "$starTime - $endTime",
                                    color: AppTheme.darkIconColor,
                                    fontSize: 15,
                                  )
                                ],
                              ),
                              Row(
                                spacing: width * 0.02,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: AppTheme.darkIconColor,
                                    size: width * 0.05,
                                  ),
                                  CustomText(
                                    text: eventLocation,
                                    color: AppTheme.darkIconColor,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                              Divider(
                                color: AppTheme.darkIconColor,
                                thickness: 2,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: height * 0.070,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "Ticket ID",
                                          color: AppTheme.darkIconColor,
                                          fontSize: 15,
                                        ),
                                        SizedBox(
                                          width: width * 0.40,
                                          child: CustomText(
                                            text: ticket.ticketId,
                                            maxLines: 2,
                                            color:
                                                AppTheme.darkTextColorSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width * 0.25,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "Price",
                                          color: AppTheme.darkIconColor,
                                          fontSize: 15,
                                        ),
                                        SizedBox(
                                          width: width * 0.20,
                                          child: CustomText(
                                            text: "₹$price",
                                            maxLines: 2,
                                            color:
                                                AppTheme.darkTextColorSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: width * 0.6,
                                  height: height * 0.15,
                                  decoration: BoxDecoration(
                                      color: AppTheme.darkTextColorSecondary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    spacing: height * 0.01,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.confirmation_number_outlined,
                                        size: 40,
                                        color: AppTheme.darkBorderColor,
                                      ),
                                      CustomText(
                                        text:
                                            "Present this ticket at the venue.",
                                        color: AppTheme.darkSecondaryColor,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                 TicketButton(width: width, height: height, label: "Download", icon: Icons.file_download_outlined ,
                                 onTap: ()async{
                                 final userName = "$userFirstName $userLastName";
                                 final formattedDate = DateFormat('dd MMM yyyy – hh:mm a').format(date); 
                                  await saveTicketToDownloads(eventName: eventTitle, ticketId: ticket.id, attendee: userName, location: eventLocation, date: formattedDate, qrBase64: qrCodeImage);
                                 },
                                 ),
                                 TicketButton(width: width, height: height, label: "Share", icon: Icons.share_outlined, 
                                 onTap: ()async{
                                    final userName = "$userFirstName $userLastName";
                                 final formattedDate = DateFormat('dd MMM yyyy – hh:mm a').format(date);
                                  await saveAndShareTicket(eventName: eventTitle, ticketId: ticket.id, attendee: userName, location: eventLocation, date: formattedDate, qrBase64: qrCodeImage);
                                 },
                                 )
                                ],
                              )
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PrimaryButton(
                  label: "Done",
                  ontap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DashBoardScreen()),
                  (route) => false,
                );
                context
                    .read<NavigationBloc>()
                    .add(NavigationTabChanged(NavigationTab.home));
                  },
                  buttonColor: Colors.blueAccent,
                  buttonTextColor: AppTheme.darkTextColorPrymary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TicketButton extends StatelessWidget {
  const TicketButton({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final double width;
  final double height;
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.35,
        height: height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.darkTextColorSecondary,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: width * 0.060,
              color: AppTheme.darkIconColor,
            ),
            SizedBox(width: width * 0.02),
            CustomText(
              text: label,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

