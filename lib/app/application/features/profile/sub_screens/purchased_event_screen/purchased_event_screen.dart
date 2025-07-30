import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/purchased_event_screen/bloc/purchased_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/purchased_event_screen/widgets/build_shimmer_card.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';

class PurchasedEventScreen extends StatefulWidget {
  const PurchasedEventScreen({super.key});

  @override
  State<PurchasedEventScreen> createState() => _PurchasedEventScreenState();
}

class _PurchasedEventScreenState extends State<PurchasedEventScreen> {
  final Set<String> cancelledTickets = {};
  bool isProcessingCancellation = false;

  Future<bool?> showCancelConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Colors.redAccent,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  'Cancel Ticket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Content
                Text(
                  'Are you sure you want to cancel this ticket? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),

                // Action buttons
                Row(
                  children: [
                    // Cancel button
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Keep Ticket',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Confirm button
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.redAccent,
                              Colors.red.shade700,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel Ticket',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) =>
          PurchasedBloc()..add(GetAllPurchasedTicketsRequrestEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: "Purchased Tickets",
            fontSize: 25,
            FontFamily: 'roboto',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "My Tickets",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Manage your purchased tickets for upcoming events",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkTextLightColor,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                BlocConsumer<PurchasedBloc, PurchasedState>(
                  listener: (context, state) {
                    if (state is CancelTicketFailureState) {
                      setState(() {
                        isProcessingCancellation = false;
                      });
                      showFailureScackbar(
                          context: context,
                          height: height,
                          title: "Failed",
                          body:
                              "Failed to Cancel the events. please try again");
                    } else if (state is CancelTicketSuccessState) {
                      setState(() {
                        cancelledTickets.add(state.cancelledEventId);
                        isProcessingCancellation = false;
                      });
                      showSuccessSnackbar(
                          context: context,
                          height: height,
                          title: "Cancelled Successfully",
                          body: "Your event has been successfully canceled");
                      // Refresh the ticket list to reflect the updated state
                      context
                          .read<PurchasedBloc>()
                          .add(GetAllPurchasedTicketsRequrestEvent());
                    } else if (state is CancelTicketLoadingState) {
                      setState(() {
                        isProcessingCancellation = true;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is PurchasedTicketLoadingState) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4, // Show 4 shimmer cards
                        itemBuilder: (context, index) =>
                            buildShimmerCard(width, height),
                      );
                    } else if (state is PurchasedTicketFailureState) {
                      return Center(
                        child: CustomText(text: state.errorMessage),
                      );
                    } else if (state is PurchasedTicketSuccessState) {
                      final purchasedList = state.purchasedEventList;

                      return purchasedList.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.2,
                                  ),
                                  LottieBuilder.asset(
                                    "assets/lottie/nodata.json",
                                    height: height * 0.20,
                                  ),
                                  CustomText(
                                    text: "No Purchase Tickets Found",
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.darkTextLightColor,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: purchasedList.length,
                              itemBuilder: (context, index) {
                                final eventdata = purchasedList[index];
                                final event = eventdata.eventId;
                                final ticketObjectId = eventdata
                                    .id; // This should map to "_id" from your JSON

                                // Check if ticket is already cancelled from the API response
                                final isAlreadyCancelled =
                                    eventdata.status == "CANCELLED";

                                // Also check local cancellation state
                                final isCancelled = isAlreadyCancelled ||
                                    cancelledTickets.contains(ticketObjectId);

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    width: double.infinity,
                                    constraints: BoxConstraints(
                                        minHeight: height * 0.24),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: AppTheme.darkSecondaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      spacing: height * 0.001,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: event.title,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        CustomText(
                                            maxLines: 5,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            text: event.description),
                                        SizedBox(
                                          height: height * 0.0050,
                                        ),
                                        Row(
                                          spacing: width * 0.02,
                                          children: [
                                            Icon(
                                              Icons.calendar_month_outlined,
                                              color: AppTheme.darkIconColor,
                                              size: width * 0.050,
                                            ),
                                            CustomText(
                                              text: DateFormat('dd-MMM-yyyy')
                                                  .format(event.date),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.0050,
                                        ),
                                        Row(
                                          spacing: width * 0.02,
                                          children: [
                                            Icon(
                                              Icons.timer_outlined,
                                              color: AppTheme.darkIconColor,
                                              size: width * 0.050,
                                            ),
                                            CustomText(
                                              text:
                                                  "${event.startTime} to ${event.endTime}",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.0050,
                                        ),
                                        Row(
                                          spacing: width * 0.02,
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: AppTheme.darkIconColor,
                                              size: width * 0.050,
                                            ),
                                            CustomText(
                                              text: event.eventLocation,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text:
                                                    "₹${event.pricePerTicket}",
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              InkWell(
                                                onTap: (isCancelled ||
                                                        isProcessingCancellation)
                                                    ? null
                                                    : () async {
                                                        final confirm =
                                                            await showCancelConfirmationDialog(
                                                                context);
                                                        if (confirm == true) {
                                                          context
                                                              .read<
                                                                  PurchasedBloc>()
                                                              .add(CancelEventRequestEvent(
                                                                  eventId:
                                                                      ticketObjectId));
                                                        }
                                                      },
                                                child: Container(
                                                  width: width * 0.25,
                                                  height: height * 0.045,
                                                  decoration: BoxDecoration(
                                                      color: isCancelled
                                                          ? Colors.grey.shade600
                                                          : isProcessingCancellation
                                                              ? Colors.orange
                                                              : Colors
                                                                  .redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  alignment: Alignment.center,
                                                  child:
                                                      isProcessingCancellation &&
                                                              !isCancelled
                                                          ? SizedBox(
                                                              width: 16,
                                                              height: 16,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .white),
                                                              ),
                                                            )
                                                          : CustomText(
                                                              text: isCancelled
                                                                  ? "Cancelled"
                                                                  : "Cancel Ticket",
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                    return SizedBox();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
