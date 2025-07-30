import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/widgets/build_event_booking_card.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/widgets/build_order_summary_section.dart';
import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/widgets/build_user_info_section.dart';
import 'package:zyra_momments_app/app/data/models/event_model.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class EventBookingScreen extends StatelessWidget {
  final Event events;
  final String posterImage;

  const EventBookingScreen({
    super.key,
    required this.events,
    required this.posterImage,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final hostingDate = DateFormat('dd-MM-yyyy').format(events.createdAt);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(width, height, hostingDate , context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: CustomText(
        text: "Book Tickets",
        fontSize: 25,
        FontFamily: 'roboto',
      ),
    );
  }

  Widget _buildBody(double width, double height, String hostingDate , BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: height * 0.013,
          children: [
            buildEventBookingCard(width, height, hostingDate ,events),
            buildUserInfoSection(width, height),
            buildOrderSummarySection(width, height , events , context),
          ],
        ),
      ),
    );
  }

 
}

  

 




















// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/bloc/event_card_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/events/event_booking_screen/payment_success_screen/payment_success_screen.dart';
// import 'package:zyra_momments_app/app/data/models/event_model.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

// class EventBookingScreen extends StatelessWidget {
//   final Event events;
//   final String posterImage;

//   const EventBookingScreen(
//       {super.key, required this.events, required this.posterImage});

//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: AppTheme.darkSecondaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Success Icon
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.check_circle,
//                   color: Colors.green,
//                   size: 50,
//                 ),
//               ),
//               SizedBox(height: 16),
//               // Success Title
//               CustomText(
//                 text: "Payment Successful!",
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//               SizedBox(height: 8),
//               // Success Message
//               CustomText(
//                 text:
//                     "Your payment has been processed successfully. Your ticket is confirmed!",
//                 fontSize: 14,
//                 color: AppTheme.darkTextLightColor,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               // Action Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close dialog
//                     // Navigate to success screen
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                         builder: (context) => PaymentSuccessScreen(
//                           eventId: events.id,
//                           eventTitle: events.title,
//                           eventLocation: events.eventLocation,
//                           date: events.date,
//                           starTime: events.startTime,
//                           endTime: events.endTime,
//                           price: events.pricePerTicket,
//                           userFirstName: events.hostId.firstName,
//                           userLastName: events.hostId.lastName,
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: CustomText(
//                     text: "View Ticket",
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     final hostingDate = DateFormat('dd-MM-yyyy').format(events.createdAt);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: CustomText(
//           text: "Book Tickets",
//           fontSize: 25,
//           FontFamily: 'roboto',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             spacing: height * 0.013,
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: height * 0.31,
//                 decoration: BoxDecoration(
//                     color: AppTheme.darkSecondaryColor,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         spacing: width * 0.02,
//                         children: [
//                           Container(
//                             width: width * 0.45,
//                             height: height * 0.13,
//                             decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(5),
//                               child: events.posterImage!.isNotEmpty
//                                   ? Image.network(
//                                       events.posterImage!,
//                                       fit: BoxFit.cover,
//                                       height: height * 0.30,
//                                       width: double.infinity,
//                                       loadingBuilder:
//                                           (context, child, loadingProgress) {
//                                         if (loadingProgress == null) {
//                                           return child;
//                                         }
//                                         return Shimmer.fromColors(
//                                           baseColor: Colors.grey.shade300,
//                                           highlightColor: Colors.grey.shade100,
//                                           child: Container(
//                                             height: height * 0.30,
//                                             width: double.infinity,
//                                             color: Colors.white,
//                                           ),
//                                         );
//                                       },
//                                       errorBuilder: (_, __, ___) => Container(
//                                         height: height * 0.15,
//                                         width: double.infinity,
//                                         color: Colors.grey[300],
//                                         child: const Icon(Icons.error),
//                                       ),
//                                     )
//                                   : Container(
//                                       height: height * 0.15,
//                                       width: double.infinity,
//                                       color: Colors.grey[300],
//                                       child:
//                                           const Icon(Icons.image_not_supported),
//                                     ),
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CustomText(
//                                 text: events.title,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               CustomText(
//                                 text: "Corporate",
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppTheme.darkTextLightColor,
//                               ),
//                               Row(
//                                 spacing: width * 0.02,
//                                 children: [
//                                   Icon(
//                                     Icons.calendar_today_outlined,
//                                     size: 16,
//                                     color: AppTheme.darkTextColorSecondary,
//                                   ),
//                                   CustomText(text: hostingDate)
//                                 ],
//                               ),
//                               Row(
//                                 spacing: width * 0.02,
//                                 children: [
//                                   Icon(
//                                     Icons.timer_outlined,
//                                     size: 16,
//                                     color: AppTheme.darkTextColorSecondary,
//                                   ),
//                                   CustomText(
//                                       text:
//                                           "${events.startTime} - ${events.endTime}")
//                                 ],
//                               ),
//                               Row(
//                                 spacing: width * 0.02,
//                                 children: [
//                                   Icon(
//                                     Icons.location_on_outlined,
//                                     size: 16,
//                                     color: AppTheme.darkTextColorSecondary,
//                                   ),
//                                   CustomText(text: events.eventLocation)
//                                 ],
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: height * 0.015,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: height * 0.14,
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             color: AppTheme.darkPrimaryColor,
//                             borderRadius: BorderRadius.circular(8),
//                             border:
//                                 Border.all(color: AppTheme.darkBorderColor)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                               text: "Select Tickets",
//                               fontSize: 18,
//                             ),
//                             CustomText(
//                               text:
//                                   "Choose the number of tickets you want to purchase",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: AppTheme.darkTextLightColor,
//                             ),
//                             Spacer(),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   children: [
//                                     CustomText(
//                                       text: "Standard Ticket",
//                                       fontSize: 18,
//                                     ),
//                                     CustomText(
//                                       text: "Access to the event",
//                                       fontWeight: FontWeight.w500,
//                                       color: AppTheme.darkTextLightColor,
//                                       fontSize: 14,
//                                     )
//                                   ],
//                                 ),
//                                 CustomText(
//                                   text: "₹ ${events.pricePerTicket}",
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: height * 0.1,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                       color: AppTheme.darkBorderColor,
//                     ),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: "Your Information",
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     SizedBox(
//                       height: height * 0.01,
//                     ),
//                     CustomText(
//                       text: "Please provide your details for the booking",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppTheme.darkTextLightColor,
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: height * 0.41,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: AppTheme.darkBorderColor)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: "Order Summary",
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     Row(
//                       children: [
//                         CustomText(
//                           text: "1 ticket × ₹${events.pricePerTicket}",
//                           fontSize: 17,
//                           color: AppTheme.darkTextLightColor,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         Spacer(),
//                         CustomText(
//                           text: "₹${events.pricePerTicket}",
//                           fontSize: 17,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         CustomText(
//                           text: "Service ",
//                           fontSize: 17,
//                           color: AppTheme.darkTextLightColor,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         Spacer(),
//                         CustomText(
//                           text: "₹0",
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: height * 0.01,
//                     ),
//                     Divider(
//                       color: AppTheme.darkTextLightColor,
//                       thickness: 2,
//                     ),
//                     SizedBox(
//                       height: height * 0.01,
//                     ),
//                     Row(
//                       children: [
//                         CustomText(
//                           text: "Total ",
//                           fontSize: 17,
//                           color: AppTheme.darkTextLightColor,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         Spacer(),
//                         CustomText(
//                           text: "₹${events.pricePerTicket}",
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: height * 0.01,
//                     ),
//                     Row(
//                       spacing: width * 0.02,
//                       children: [
//                         CircleAvatar(
//                           radius: width * 0.01,
//                           backgroundColor: AppTheme.darkTextColorSecondary,
//                         ),
//                         CustomText(
//                           text: "All prices are inclusive of taxes",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: height * 0.001,
//                     ),
//                     Row(
//                       spacing: width * 0.02,
//                       children: [
//                         CircleAvatar(
//                           radius: width * 0.01,
//                           backgroundColor: AppTheme.darkTextColorSecondary,
//                         ),
//                         CustomText(
//                           text: "Tickets are non-refundable",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       spacing: width * 0.02,
//                       children: [
//                         CircleAvatar(
//                           radius: width * 0.01,
//                           backgroundColor: AppTheme.darkTextColorSecondary,
//                         ),
//                         CustomText(
//                           text:
//                               "Tickets are valid only for the date and time mentioned",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       spacing: width * 0.02,
//                       children: [
//                         CircleAvatar(
//                           radius: width * 0.01,
//                           backgroundColor: AppTheme.darkTextColorSecondary,
//                         ),
//                         CustomText(
//                           text: "Each ticket admits one person only",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: height * 0.02,
//                     ),
//                     CustomText(
//                       text: "Complete Your Payment",
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     BlocListener<EventCardBloc, EventCardState>(
//                       listener: (context, state) {
//                         if (state is EventCardPaymentSuccessState) {
//                           _showSuccessDialog(context);
//                         } else {
//                           _showFailureDialog(context, state.errorMessage!);
//                         }
//                       },
//                       child: BlocBuilder<EventCardBloc, EventCardState>(
//                         builder: (context, state) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                             child: GestureDetector(
//                               onTap: state.isSubmitting
//                                   ? null
//                                   : () {
//                                       context.read<EventCardBloc>().add(
//                                             EventConfirmPaymentEventReqeust(
//                                                 amount: "49"), // in paisa
//                                           );
//                                     },
//                               child: Container(
//                                 width: double.infinity,
//                                 height: height * 0.065,
//                                 decoration: BoxDecoration(
//                                     color: state.isSubmitting
//                                         ? Colors.grey
//                                         : AppTheme.paymentButtonColor,
//                                     borderRadius: BorderRadius.circular(5)),
//                                 alignment: Alignment.center,
//                                 child: state.isSubmitting
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                             width: 20,
//                                             height: 20,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                               valueColor:
//                                                   AlwaysStoppedAnimation<Color>(
//                                                       Colors.white),
//                                             ),
//                                           ),
//                                           SizedBox(width: 10),
//                                           CustomText(
//                                             text: "Processing...",
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ],
//                                       )
//                                     : CustomText(
//                                         text:
//                                             "Continue Payment - ₹${events.pricePerTicket}",
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Container(
//               //   width: width * 0.2,
//               //   height: height * 0.040,
//               //   color: Colors.green,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showFailureDialog(BuildContext context, String errorMessage) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: AppTheme.darkSecondaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Error Icon
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.red.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.error_outline,
//                   color: Colors.red,
//                   size: 50,
//                 ),
//               ),
//               SizedBox(height: 16),
//               // Error Title
//               CustomText(
//                 text: "Payment Failed",
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//               SizedBox(height: 8),
//               // Error Message
//               CustomText(
//                 text: errorMessage,
//                 fontSize: 14,
//                 color: AppTheme.darkTextLightColor,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               // Action Buttons
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close dialog
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: CustomText(
//                         text: "Cancel",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close dialog
//                         // Optionally retry payment
//                         context.read<EventCardBloc>().add(
//                               EventConfirmPaymentEventReqeust(
//                                   amount: "49"), // in paisa
//                             );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.paymentButtonColor,
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: CustomText(
//                         text: "Retry",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


// //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4MGEyNDE0NWFmNDhhYTNjY2I1OWFhOCIsImVlsIjoidGlqYWw1ODc4MEBsaW51eHVlcy5jb20iLCJyb2xlIjoidmVuZG9yIiwiaWF0IjoxNzUyOTA5MDg1LCJleHAiOjE3NTI5MDkwOTVdWV1xQIG7HdR66Ikyy3rdsINBhCo3NYWO740Fqp5I