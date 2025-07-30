import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/widgets/booking_details_shimmer.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/widgets/build_date_and_time_section.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/widgets/build_header_section.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/widgets/build_payment_section.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/widgets/build_people_section.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/widgets/build_service_info_section.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/widgets/build_status_indicators.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';

class BookingDetailsScreen extends StatefulWidget {
  final ServiceDetails service;
  final DateTime date;
  final TimeSlot time;
  final RId user;
  final RId vendor;
  final int totalPrice;
  final String paymentId;
  final String paymentSatus;
  final String status;

  const BookingDetailsScreen({
    super.key,
    required this.service,
    required this.date,
    required this.time,
    required this.user,
    required this.vendor,
    required this.totalPrice,
    required this.paymentId,
    required this.paymentSatus,
    required this.status,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? _buildShimmerEffect(context)
            : _buildContent(context),
      ),
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return buildShimmerEffect(width, height);
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderSection(),
            const SizedBox(height: 12),
            buildStatusIndicators(widget.status , widget.paymentSatus),
            const SizedBox(height: 24),
            buildServiceInfoSection(widget.service),
            const SizedBox(height: 24),
            buildDateTimeSection(widget.date , widget.time),
            const SizedBox(height: 24),
            buildPeopleSection(widget.user , widget.vendor),
            const SizedBox(height: 24),
            buildPaymentSection(context , widget.paymentId , widget.paymentSatus , widget.totalPrice),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  

 



 


 
}









// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/widgets/booking_details_shimmer.dart';
// import 'package:zyra_momments_app/app/data/models/service_model.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

// class BookingDetailsScreen extends StatefulWidget {
//   final ServiceDetails service;
//   final DateTime date;
//   final TimeSlot time;
//   final RId user;
//   final RId vendor;
//   final int totalPrice;
//   final String paymentId;
//   final String paymentSatus;
//   final String status;

//   const BookingDetailsScreen({
//     super.key,
//     required this.service,
//     required this.date,
//     required this.time,
//     required this.user,
//     required this.vendor,
//     required this.totalPrice,
//     required this.paymentId,
//     required this.paymentSatus,
//     required this.status
//   });

//   @override
//   State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
// }

// class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     // Simulate a loading delay (e.g., 2 seconds) to show shimmer effect
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     });
//   }

//   String formatTime(String timeStr) {
//     final parsedTime = DateFormat("HH:mm").parse(timeStr); // from 24-hr format
//     return DateFormat.jm().format(parsedTime); // to 12-hr format like "3:30 PM"
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;

//     return SafeArea(
//       child: Scaffold(
//         body: _isLoading
//             ? buildShimmerEffect(width, height)
//             : SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         text: "Booking Details",
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       CustomText(
//                         text: "Booking id : dsfghiu23sdfhkjsdfh",
//                         color: AppTheme.darkIconColor,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       const SizedBox(height: 12),
//                       // Status indicators
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: widget.status == 'pending'
//                                   ? Colors.amber.withAlpha(84)
//                                   : Colors.green.withAlpha(84),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.timer_outlined,
//                                   color: AppTheme.darkTextColorSecondary,
//                                   size: 15,
//                                 ),
//                                 const SizedBox(width: 4),
//                                 CustomText(
//                                   text: widget.paymentSatus == 'pending' ? 'Pending' : 'Succeeded',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               // color: Colors.grey.withAlpha(84),
//                                color: widget.paymentSatus == 'pending'
//                                   ? Colors.amber.withAlpha(84)
//                                   : Colors.green.withAlpha(84),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.timer_outlined,
//                                   color: AppTheme.darkTextColorSecondary,
//                                   size: 15,
//                                 ),
//                                 const SizedBox(width: 4),
//                                 CustomText(
                                
//                                   text: widget.paymentSatus == 'pending' ? 'Pending' : '₹ Succeeded',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//                       // Service info section
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.info_outline,
//                             color: AppTheme.darkTextColorSecondary,
//                           ),
//                           const SizedBox(width: 8),
//                           CustomText(
//                             text: "Service Info",
//                             fontSize: 25,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: AppTheme.darkSecondaryColor,
//                         ),
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomText(
//                               text: widget.service.serviceTitle,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             const SizedBox(height: 8),
//                             CustomText(
//                               maxLines: null,
//                               text: widget.service.serviceDescription,
//                               fontSize: 15,
//                               color: AppTheme.darkTextLightColor,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             const SizedBox(height: 20),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CustomText(
//                                         text: "Duration",
//                                         color: AppTheme.darkTextLightColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       CustomText(
//                                         text:
//                                             "${widget.service.serviceDuration} hours",
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       const SizedBox(height: 16),
//                                       CustomText(
//                                         text: "Additional Hour Price",
//                                         color: AppTheme.darkTextLightColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       CustomText(
//                                         text:
//                                             "₹${widget.service.additionalHoursPrice}.00",
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CustomText(
//                                         text: "Base Price",
//                                         color: AppTheme.darkTextLightColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       CustomText(
//                                         text: "₹7000.00",
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       const SizedBox(height: 16),
//                                       CustomText(
//                                         text: "Total Price",
//                                         color: AppTheme.darkTextLightColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       CustomText(
//                                         text:
//                                             "₹${widget.service.servicePrice}.00",
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       // Date & Time section
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.date_range_outlined,
//                             color: AppTheme.darkTextColorSecondary,
//                           ),
//                           const SizedBox(width: 8),
//                           CustomText(
//                             text: "Date and Time",
//                             fontSize: 25,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16.0),
//                         decoration: BoxDecoration(
//                           color: AppTheme.darkSecondaryColor,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                     text: "Date",
//                                     color: AppTheme.darkTextLightColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   CustomText(
//                                     text: DateFormat("dd-MM-yyyy")
//                                         .format(widget.date),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                     text: "Time",
//                                     color: AppTheme.darkTextLightColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   CustomText(
//                                     text:
//                                         "${formatTime(widget.time.startTime)} - ${formatTime(widget.time.endTime)}",
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       // People section
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.person_2_outlined,
//                             color: AppTheme.darkTextColorSecondary,
//                           ),
//                           const SizedBox(width: 8),
//                           CustomText(
//                             text: "People",
//                             fontSize: 25,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               padding: const EdgeInsets.all(16.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: AppTheme.darkSecondaryColor,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                     text: "Client",
//                                     fontSize: 15,
//                                     color: AppTheme.darkTextLightColor,
//                                   ),
//                                   CustomText(
//                                     text:
//                                         "${widget.user.firstName} ${widget.user.lastName}",
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   CustomText(
//                                     text: "id: ${widget.user.id}",
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     color: AppTheme.darkTextLightColor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Container(
//                               padding: const EdgeInsets.all(16.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: AppTheme.darkSecondaryColor,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(
//                                     text: "Vendor",
//                                     fontSize: 15,
//                                     color: AppTheme.darkTextLightColor,
//                                   ),
//                                   CustomText(
//                                     text:
//                                         "${widget.vendor.firstName} ${widget.vendor.lastName}",
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   CustomText(
//                                     text: "id: ${widget.vendor.id}",
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     color: AppTheme.darkTextLightColor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//                       // Payment section
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.currency_rupee,
//                             color: AppTheme.darkTextColorSecondary,
//                           ),
//                           const SizedBox(width: 8),
//                           CustomText(
//                             text: "Payment",
//                             fontSize: 25,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16.0),
//                         decoration: BoxDecoration(
//                           color: AppTheme.darkSecondaryColor,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: double.infinity,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomText(
//                                     text: "Payment iD",
//                                     color: AppTheme.darkTextLightColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   CustomText(
//                                     text: widget.paymentId,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: height * 0.01),
//                             SizedBox(
//                               width: double.infinity,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomText(
//                                     text: "Status",
//                                     color: AppTheme.darkTextLightColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   CustomText(
//                                     text: widget.paymentSatus,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Divider(
//                               color: AppTheme.darkBorderColor,
//                               thickness: 2,
//                             ),
//                             SizedBox(
//                               width: double.infinity,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomText(
//                                     text: "Total Amount",
//                                     color: AppTheme.darkTextLightColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   CustomText(
//                                     text: "₹${widget.totalPrice}.00",
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 22,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
