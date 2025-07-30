//   import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/add_date_bloc/bloc/add_date_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_state.dart';
// import 'package:zyra_momments_app/app/data/models/vendor_booking_model.dart' as booking;
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

// Widget buildPaymentButton(double width, double height, double totalAmount) {
//     return BlocBuilder<ServiceBookingBloc, ServiceBookingState>(
//       builder: (context, state) {
//         final addDateState = context.read<AddDateBloc>().state;
        
//         final isFormComplete = _isFormComplete(state, addDateState);

//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5),
//           child: GestureDetector(
//             onTap: state is ServiceBookingLoadingState ? null : () => _handlePaymentButtonPress(),
//             child: Container(
//               width: double.infinity,
//               height: height * 0.07,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: state is ServiceBookingLoadingState
//                     ? Colors.grey[600]
//                     : (isFormComplete ? Colors.blueAccent : Colors.grey),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: state is ServiceBookingLoadingState
//                   ? _buildLoadingIndicator()
//                   : CustomText(
//                       text: "Pay ₹${totalAmount.toStringAsFixed(2)}",
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   bool _isFormComplete(ServiceBookingState state, AddDateState addDateState , TextEditingController contactController ,TextEditingController emailController) {
//     return state.selectedServiceId != null &&
//         addDateState.selectedDate != null &&
//         addDateState.selectedTimeSlot != null &&
//         contactController.text.trim().isNotEmpty &&
//         emailController.text.trim().isNotEmpty &&
//         contactController.text.trim().length >= 10 &&
//         RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text.trim());
//   }

//   Widget _buildLoadingIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: 20,
//           height: 20,
//           child: CircularProgressIndicator(
//             strokeWidth: 2,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//           ),
//         ),
//         SizedBox(width: 10),
//         CustomText(
//           text: "Processing...",
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ],
//     );
//   }

//   void _handlePaymentButtonPress(BuildContext context) {
//     final serviceBookingState = context.read<ServiceBookingBloc>().state;
//     final addDateState = context.read<AddDateBloc>().state;

//     if (_isFormComplete(serviceBookingState, addDateState, )) {
//       final timeSlotParts = addDateState.selectedTimeSlot!.split(' - ');
//       final requestData = booking.VendorBookingModel(
//         amount: serviceBookingState.totalAmount!.toDouble(),
//         purpose: "vendor-booking",
//         bookingData: booking.BookingData(
//           bookingDate: DateFormat('yyyy-MM-dd').format(addDateState.selectedDate!),
//           serviceId: serviceBookingState.selectedServiceId!,
//           timeSlot: booking.TimeSlot(
//             startTime: timeSlotParts[0],
//             endTime: timeSlotParts[1],
//           ),
//         ),
//         totalPrice: serviceBookingState.totalAmount!.toDouble(),
//         vendorId: serviceBookingState.vendorId!,
//         createrType: "Client",
//         receiverType: "Vendor",
//       );

//       log('Booking Request: ${requestData.toJson()}');
//       context.read<ServiceBookingBloc>().add(
//         ConfirmPaymentForService(vendorBookingData: requestData),
//       );
//     } else {
//       context.read<ServiceBookingBloc>().add(const ValidateForm());
//     }
//   }
// }