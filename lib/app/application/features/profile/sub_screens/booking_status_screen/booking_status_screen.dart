import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/bloc/booking_status_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/widgets/build_booking_item.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/widgets/build_booking_shimmer.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class BookingStatusScreen extends StatelessWidget {
  const BookingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          BookingStatusBloc()..add(GetAllBookingStatusRequestEvent()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context, height),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: CustomText(
        text: "Booking Status",
        fontSize: 25,
        FontFamily: 'shafarik',
      ),
    );
  }

  Widget _buildBody(BuildContext context, double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppTheme.darkBorderColor),
        ),
        child: BlocBuilder<BookingStatusBloc, BookingStatusState>(
          builder: (context, state) {
            if (state is BookingStatusLoadingState) {
              return buildBookingShimmer(context);
            } else if (state is BookingStatusFailureState) {
              return Center(child: CustomText(text: state.errorMessage));
            } else if (state is BookingStatusSuccessState) {
              return _buildBookingList(context, state, height);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildBookingList(
      BuildContext context, BookingStatusSuccessState state, double height) {
    return state.bookings.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: height * 0.050,
                // ),
                LottieBuilder.asset(
                  "assets/lottie/nodata.json",
                  height: height * 0.20,
                ),
                CustomText(
                  text: "No Bookings Found",
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkTextLightColor,
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.bookings.length,
            itemBuilder: (context, index) {
              final booking = state.bookings[index];
              return buildBookingItem(context, booking, index, state);
            },
          );
  }
}











// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/booking_details_screen.dart';
// import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/bloc/booking_status_bloc.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

// class BookingStatusScreen extends StatelessWidget {
//   const BookingStatusScreen({super.key});

//   // Helper function to handle unknown statuses gracefully
//   String _normalizeStatus(String status) {
//     const allowedStatuses = ['pending', 'completed', 'cancelled'];
//     if (allowedStatuses.contains(status)) {
//       return status;
//     }
//     // Map unknown statuses to known ones
//     switch (status.toLowerCase()) {
//       case 'confirmed':
//       case 'approved':
//         return 'completed';
//       case 'rejected':
//       case 'declined':
//         return 'cancelled';
//       default:
//         return 'pending';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return BlocProvider(
//       create: (context) =>
//           BookingStatusBloc()..add(GetAllBookingStatusRequestEvent()),
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: CustomText(
//             text: "Booking Status",
//             fontSize: 25,
//             FontFamily: 'shafarik',
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(color: AppTheme.darkBorderColor),
//             ),
//             child: BlocBuilder<BookingStatusBloc, BookingStatusState>(
//               builder: (context, state) {
//                 if (state is BookingStatusLoadingState) {
//                   return _buildBookingShimmer(width, height);
//                 } else if (state is BookingStatusFailureState) {
//                   return Center(child: CustomText(text: state.errorMessage));
//                 } else if (state is BookingStatusSuccessState) {
//                   return ListView.builder(
//                     padding: const EdgeInsets.all(8.0),
//                     itemCount: state.bookings.length,
//                     itemBuilder: (context, index) {
//                       final booking = state.bookings[index].serviceDetails;
//                       final timeSlot = state.bookings[index].timeSlot;
//                       final vendor = state.bookings[index].vendorId;
//                       final date = state.bookings[index].bookingDate;
//                       final userDetails = state.bookings[index].userId;
//                       final vendorDetails = state.bookings[index].vendorId;
//                       final totalPrice = state.bookings[index].totalPrice;
//                       final paymentId = state.bookings[index].paymentId;
//                       final paymentStatus = state.bookings[index].paymentStatus;
//                       final status = state.bookings[index].status;
//                       final normalizedStatus = _normalizeStatus(status);
                      
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 10),
//                         child: GestureDetector(
//                           onTap: () =>
//                               Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => BookingDetailsScreen(
//                               service: booking,
//                               date: date,
//                               time: timeSlot,
//                               user: userDetails,
//                               vendor: vendorDetails,
//                               paymentId: paymentId,
//                               paymentSatus: paymentStatus,
//                               totalPrice: totalPrice,
//                               status: status,
//                             ),
//                           )),
//                           child: Container(
//                             width: double.infinity,
//                             // Removed fixed height to prevent overflow
//                             decoration: BoxDecoration(
//                               color: AppTheme.darkSecondaryColor,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize
//                                     .min, // Ensure Column takes only needed space
//                                 children: [
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           CustomText(
//                                               text: "Service",
//                                               color: AppTheme.darkIconColor),
//                                           CustomText(
//                                               text: "Customer",
//                                               color: AppTheme.darkIconColor),
//                                           CustomText(
//                                               text: "Date",
//                                               color: AppTheme.darkIconColor),
//                                           CustomText(
//                                               text: "Price",
//                                               color: AppTheme.darkIconColor),
//                                           CustomText(
//                                               text: "Status",
//                                               color: AppTheme.darkIconColor),
//                                         ],
//                                       ),
//                                       SizedBox(width: width * 0.02),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           CustomText(
//                                               text:
//                                                   ":   ${booking.serviceTitle}"),
//                                           CustomText(
//                                               text:
//                                                   ":   ${vendor.firstName}${vendor.lastName}"),
//                                           CustomText(
//                                               text:
//                                                   ":   ${DateFormat('dd-MM-yyyy').format(date)}"),
//                                           CustomText(text: ":   ₹$totalPrice"),
//                                           Container(
//                                             width: width * 0.25,
//                                             height: width * 0.06,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               color: () {
//                                                 if (normalizedStatus == 'completed') {
//                                                   return Colors.green
//                                                       .withAlpha(84);
//                                                 } else if (normalizedStatus == 'cancelled') {
//                                                   return Colors.red
//                                                       .withAlpha(84);
//                                                 } else {
//                                                   return Colors.amber
//                                                       .withAlpha(84);
//                                                 }
//                                               }(),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Icon(
//                                                   normalizedStatus == 'completed'
//                                                       ? Icons
//                                                           .check_circle_outline
//                                                       : normalizedStatus == 'cancelled'
//                                                           ? Icons
//                                                               .cancel_outlined
//                                                           : Icons
//                                                               .timer_outlined,
//                                                   color: AppTheme
//                                                       .darkTextColorSecondary,
//                                                   size: 15,
//                                                 ),
//                                                 SizedBox(width: 4),
//                                                 CustomText(
//                                                   text: normalizedStatus == 'completed'
//                                                       ? "succeeded"
//                                                       : normalizedStatus == 'cancelled'
//                                                           ? "cancelled"
//                                                           : "pending",
//                                                   fontWeight: FontWeight.w500,
//                                                 )
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                       height:
//                                           8), // Replaced Spacer with fixed spacing
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Container(
//                                         width: width * 0.38,
//                                         height: width * 0.095,
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: AppTheme.darkBorderColor),
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           color: AppTheme.darkPrimaryColor,
//                                         ),
//                                         child: DropdownButtonHideUnderline(
//                                           child: DropdownButton<String>(
//                                             value: normalizedStatus,
//                                             dropdownColor:
//                                                 AppTheme.darkPrimaryColor,
//                                             style: TextStyle(
//                                                 color: AppTheme
//                                                     .darkTextColorSecondary),
//                                             items: [
//                                               'pending',
//                                               'completed',
//                                               'cancelled'
//                                             ].map((String value) {
//                                               return DropdownMenuItem<String>(
//                                                 value: value,
//                                                 child: CustomText(text: value),
//                                               );
//                                             }).toList(),
//                                             onChanged: (newValue) {
//                                               if (newValue != null &&
//                                                   newValue != normalizedStatus) {
//                                                 context
//                                                     .read<BookingStatusBloc>()
//                                                     .add(
//                                                         UpdatBookingStatusEvent(
//                                                             bookingId: state
//                                                                 .bookings[index]
//                                                                 .id,
//                                                             status: newValue));
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return SizedBox();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBookingShimmer(double width, double height) {
//     return Shimmer.fromColors(
//       baseColor: AppTheme.darkShimmerBaseColor,
//       highlightColor: AppTheme.darkShimmerHeighlightColor,
//       child: ListView.builder(
//         padding: const EdgeInsets.all(8.0),
//         itemCount: 3, // Simulate 3 placeholder booking items
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: Container(
//               width: double.infinity,
//               // Removed fixed height to prevent overflow
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisSize:
//                       MainAxisSize.min, // Ensure Column takes only needed space
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: List.generate(
//                             5,
//                             (index) => Padding(
//                               padding: const EdgeInsets.only(bottom: 8.0),
//                               child: Container(
//                                 width: 80,
//                                 height: 16,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: width * 0.02),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: 120,
//                               height: 16,
//                               color: Colors.white,
//                               margin: const EdgeInsets.only(bottom: 8.0),
//                             ),
//                             Container(
//                               width: 100,
//                               height: 16,
//                               color: Colors.white,
//                               margin: const EdgeInsets.only(bottom: 8.0),
//                             ),
//                             Container(
//                               width: 80,
//                               height: 16,
//                               color: Colors.white,
//                               margin: const EdgeInsets.only(bottom: 8.0),
//                             ),
//                             Container(
//                               width: 60,
//                               height: 16,
//                               color: Colors.white,
//                               margin: const EdgeInsets.only(bottom: 8.0),
//                             ),
//                             Container(
//                               width: width * 0.25,
//                               height: width * 0.06,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8), // Replaced Spacer with fixed spacing
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           width: width * 0.38,
//                           height: width * 0.095,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



