import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/add_date_bloc/bloc/add_date_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_state.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/widgets/build_contact_info_section.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/widgets/build_date_picker_selection.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/widgets/build_service_drop_down.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/widgets/build_summury_section.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/widgets/build_time_slot_selection.dart';
import 'package:zyra_momments_app/app/data/models/vendor_booking_model.dart'
    as booking;
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';

class ServiceBookingScreen extends StatefulWidget {
  final List<Service> services;
  const ServiceBookingScreen({super.key, required this.services});

  @override
  State<ServiceBookingScreen> createState() => _ServiceBookingScreenState();
}

class _ServiceBookingScreenState extends State<ServiceBookingScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late List<DateTime> availableDates;

  @override
  void initState() {
    super.initState();
    // Clear all form controllers
    dateController.clear();
    contactController.clear();
    emailController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBookingBloc>().add(const ResetFormEvent());

      context.read<AddDateBloc>().add(ClearDateEvent());
    });
    _initializeAvailableDates();
  }

  void _initializeAvailableDates() {
    availableDates = widget.services
        .expand((service) => service.availableDates)
        .map((availableDate) => availableDate.date)
        .toList();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    availableDates = availableDates.where((date) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      return !dateOnly.isBefore(today);
    }).toList();

    availableDates.sort();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final service = widget.services.first;

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<ServiceBookingBloc, ServiceBookingState>(
        listener: _handleBookingStateChanges,
        child: _buildBookingForm(width, height, service),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: CustomText(
        text: "Booking Details",
        fontSize: 25,
        FontFamily: 'roboto',
      ),
    );
  }

  void _handleBookingStateChanges(
      BuildContext context, ServiceBookingState state) {
    if (state is ServiceBookingPaymentSuccessState) {
      showSuccessSnackbar(
        context: context,
        height: MediaQuery.of(context).size.height,
        title: "🎉 Payment Successful!",
        body: "Your booking has been confirmed. Thank you for choosing us!",
      );
      Navigator.pop(context);
    } else if (state is ServiceBookingPaymentFailureState) {
      showFailureScackbar(
        context: context,
        height: MediaQuery.of(context).size.height,
        title: 'Payment Failed',
        body: state.errorMessage.toString(),
      );
    }
  }

  Widget _buildBookingForm(double width, double height, Service service) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.darkBorderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: height * 0.008,
              children: [
                SizedBox(height: height * 0.01),
                buildServiceDropdown(
                    width, height, widget.services, dateController),
                buildDatePickerSection(width, height, dateController,
                    widget.services, availableDates),
                buildTimeSlotSection(height, widget.services),
                buildContactInfoSection(
                    context, contactController, emailController),
                buildSummarySection(height, service),
                _buildPaymentButton(
                    width, height, service.servicePrice.toDouble()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(double width, double height, double totalAmount) {
    return BlocBuilder<ServiceBookingBloc, ServiceBookingState>(
      builder: (context, state) {
        final addDateState = context.read<AddDateBloc>().state;

        final isFormComplete = _isFormComplete(state, addDateState);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: state is ServiceBookingLoadingState
                ? null
                : () => _handlePaymentButtonPress(),
            child: Container(
              width: double.infinity,
              height: height * 0.07,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: state is ServiceBookingLoadingState
                    ? Colors.grey[600]
                    : (isFormComplete ? Colors.blueAccent : Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: state is ServiceBookingLoadingState
                  ? _buildLoadingIndicator()
                  : CustomText(
                      text: "Pay ₹${totalAmount.toStringAsFixed(2)}",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
            ),
          ),
        );
      },
    );
  }

  bool _isFormComplete(ServiceBookingState state, AddDateState addDateState) {
    return state.selectedServiceId != null &&
        addDateState.selectedDate != null &&
        addDateState.selectedTimeSlot != null &&
        contactController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        contactController.text.trim().length >= 10 &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text.trim());
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        SizedBox(width: 10),
        CustomText(
          text: "Processing...",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  void _handlePaymentButtonPress() {
    final serviceBookingState = context.read<ServiceBookingBloc>().state;
    final addDateState = context.read<AddDateBloc>().state;

    if (_isFormComplete(serviceBookingState, addDateState)) {
      final timeSlotParts = addDateState.selectedTimeSlot!.split(' - ');
      final requestData = booking.VendorBookingModel(
        amount: serviceBookingState.totalAmount!.toDouble(),
        purpose: "vendor-booking",
        bookingData: booking.BookingData(
          bookingDate:
              DateFormat('yyyy-MM-dd').format(addDateState.selectedDate!),
          serviceId: serviceBookingState.selectedServiceId!,
          timeSlot: booking.TimeSlot(
            startTime: timeSlotParts[0],
            endTime: timeSlotParts[1],
          ),
        ),
        totalPrice: serviceBookingState.totalAmount!.toDouble(),
        vendorId: serviceBookingState.vendorId!,
        createrType: "Client",
        receiverType: "Vendor",
      );

      log('Booking Request: ${requestData.toJson()}');
      context.read<ServiceBookingBloc>().add(
            ConfirmPaymentForService(vendorBookingData: requestData),
          );
    } else {
      context.read<ServiceBookingBloc>().add(const ValidateForm());
    }
  }
}











// // // service_booking_screen.dart
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:intl/intl.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/add_date_bloc/bloc/add_date_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_state.dart';
// import 'package:zyra_momments_app/app/data/models/vendor_booking_model.dart' as booking;
// import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
// import 'package:zyra_momments_app/application/config/theme.dart';
// import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
// import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
// import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';

// class ServiceBookingScreen extends StatefulWidget {
//   final List<Service> services;
//   const ServiceBookingScreen({super.key, required this.services});

//   @override
//   State<ServiceBookingScreen> createState() => _ServiceBookingScreenState();
// }

// class _ServiceBookingScreenState extends State<ServiceBookingScreen> {
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController zipCodeController = TextEditingController();
//   final TextEditingController contactController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   late List<DateTime> availableDates;
//   CardFieldInputDetails? cardDetails;

//   @override
//   void initState() {
//     super.initState();
//     // Initially collect all available dates from services and filter future dates only
//     availableDates = widget.services
//         .expand((service) => service.availableDates)
//         .map((availableDate) => availableDate.date)
//         .toList();

//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);

//     availableDates = availableDates.where((date) {
//       final dateOnly = DateTime(date.year, date.month, date.day);
//       return !dateOnly.isBefore(today);
//     }).toList();

//     availableDates.sort();
//   }

//   Future<void> selectDate(BuildContext context) async {
//     final selectedServiceId = context.read<ServiceBookingBloc>().state.selectedServiceId;

//     if (selectedServiceId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a service first')),
//       );
//       return;
//     }

//     final selectedService = widget.services.firstWhere((service) => service.id == selectedServiceId);

//     availableDates = selectedService.availableDates.map((availableDate) => availableDate.date).toList();

//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);

//     availableDates = availableDates.where((date) {
//       final dateOnly = DateTime(date.year, date.month, date.day);
//       return !dateOnly.isBefore(today);
//     }).toList();

//     if (availableDates.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No upcoming available dates found')),
//       );
//       return;
//     }

//     availableDates.sort();

//     try {
//       final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: availableDates.first,
//         firstDate: availableDates.first,
//         lastDate: availableDates.last,
//         selectableDayPredicate: (date) => availableDates.any((d) =>
//             d.year == date.year && d.month == date.month && d.day == date.day),
//         builder: (context, child) => Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.dark(
//               primary: Colors.teal,
//               onPrimary: Colors.white,
//               surface: AppTheme.darkSecondaryColor,
//               onSurface: Colors.white,
//             ),
//             dialogTheme: const DialogThemeData(backgroundColor: Colors.black),
//           ),
//           child: child!,
//         ),
//       );

//       if (pickedDate != null) {
//         dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//         context.read<AddDateBloc>().add(DateSelectEvent(selectedDate: pickedDate));
//         // Also update the ServiceBookingBloc
//         context.read<ServiceBookingBloc>().add(DateSelected(selectedDate: pickedDate));
//       }
//     } catch (e) {
//       log("Date picker error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error selecting date: $e')),
//       );
//     }
//   }

//   void _handlePaymentButtonPress() {
//     final serviceBookingState = context.read<ServiceBookingBloc>().state;
//     final addDateState = context.read<AddDateBloc>().state;

//     if (addDateState.selectedDate != null &&
//         addDateState.selectedTimeSlot != null &&
//         serviceBookingState.selectedServiceId != null &&
//         serviceBookingState.vendorId != null &&
//         serviceBookingState.totalAmount != null &&
//         contactController.text.isNotEmpty &&
//         emailController.text.isNotEmpty) {
      
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

//       // Trigger payment flow
//       context.read<ServiceBookingBloc>().add(
//         ConfirmPaymentForService(vendorBookingData: requestData),
//       );
//     } else {
//       // Trigger validation to show errors
//       context.read<ServiceBookingBloc>().add(const ValidateForm());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final services = widget.services.first;
//     final serviceTitle = services.serviceTitle;
//     final totalAmount = services.servicePrice;

//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: CustomText(
//           text: "Booking Details",
//           fontSize: 25,
//           FontFamily: 'roboto',
//         ),
//       ),
//       body: BlocListener<ServiceBookingBloc, ServiceBookingState>(
//         listener: (context, state) {
//           if (state is ServiceBookingPaymentSuccessState) {
//             showSuccessSnackbar(context: context, height: height, title: "🎉 Payment Successful!", body: "Your booking has been confirmed. Thank you for choosing us!");
//             // Navigate back or to success screen
//             Navigator.pop(context);
//           } else if (state is ServiceBookingPaymentFailureState) {
//             showFailureScackbar(context: context, height: height, title: 'Payment Failed', body: state.errorMessage.toString());
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               border: Border.all(color: AppTheme.darkBorderColor),
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   spacing: height * 0.008,
//                   children: [
//                     SizedBox(height: height * 0.01),
                    
//                     // Service Selection
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: CustomText(
//                         text: "Choose Service",
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: AppTheme.darkBoxColor,
//                         ),
//                         child: BlocBuilder<ServiceBookingBloc, ServiceBookingState>(
//                           builder: (context, state) {
//                             final availableServiceIds = widget.services
//                                 .map((service) => service.id)
//                                 .toSet()
//                                 .toList();
//                             final validSelectedServiceId = availableServiceIds
//                                     .contains(state.selectedServiceId)
//                                 ? state.selectedServiceId
//                                 : null;

//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 DropdownButtonFormField<String>(
//                                   hint: CustomText(text: "Select category"),
//                                   value: validSelectedServiceId,
//                                   padding: EdgeInsets.symmetric(horizontal: 5),
//                                   dropdownColor: AppTheme.darkPrimaryVarientColor,
//                                   focusColor: Colors.yellow,
//                                   borderRadius: BorderRadius.circular(8),
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                   ),
//                                   items: widget.services.map((service) {
//                                     return DropdownMenuItem<String>(
//                                       value: service.id,
//                                       child: CustomText(text: service.serviceTitle),
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     if (value != null) {
//                                       final selectedService = widget.services
//                                           .firstWhere((service) => service.id == value);
//                                       context.read<ServiceBookingBloc>().add(
//                                             ServiceSelected(
//                                               selectedServiceId: value,
//                                               vendorId: selectedService.vendorId,
//                                               totalAmount: selectedService.servicePrice,
//                                             ),
//                                           );
//                                       context.read<AddDateBloc>().add(ClearDateEvent());
//                                       dateController.clear();
//                                     }
//                                   },
//                                 ),
//                                 if (state.selectedServiceId == null && state.formError != null)
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                                     child: CustomText(
//                                       text: state.formError!,
//                                       color: Colors.red,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),

//                     // Date Selection
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: CustomText(
//                         text: "Pick Available date",
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     BlocBuilder<AddDateBloc, AddDateState>(
//                       builder: (context, state) {
//                         if (state.selectedDate != null) {
//                           final formattedDate = DateFormat('dd-MM-yyyy')
//                               .format(state.selectedDate!);
//                           dateController.text = formattedDate;
//                         }
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SecondaryTextFeild(
//                               controller: dateController,
//                               readOnly: true,
//                               hintText: "Pick date",
//                               onTap: () {
//                                 log("date field tapped - calling selectDate");
//                                 selectDate(context);
//                               },
//                             ),
//                             if (state.selectedDate == null &&
//                                 context.read<ServiceBookingBloc>().state.formError != null)
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                                 child: CustomText(
//                                   text: context.read<ServiceBookingBloc>().state.formError!,
//                                   color: Colors.red,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                           ],
//                         );
//                       },
//                     ),

//                     // Time Slot Selection
//                     Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(5),
//                       constraints: BoxConstraints(minHeight: height * 0.2),
//                       decoration: BoxDecoration(),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           BlocBuilder<AddDateBloc, AddDateState>(
//                             builder: (context, state) {
//                               if (state.selectedDate == null) {
//                                 return SizedBox.shrink();
//                               }
//                               DateTime selectedDate = state.selectedDate!;
//                               List<String> timeSlots = [];

//                               for (var service in widget.services) {
//                                 for (var availableDates in service.availableDates) {
//                                   if (availableDates.date.year == selectedDate.year &&
//                                       availableDates.date.month == selectedDate.month &&
//                                       availableDates.date.day == selectedDate.day) {
//                                     timeSlots.addAll(availableDates.timeSlots
//                                         .map((e) => "${e.startTime} - ${e.endTime}"));
//                                   }
//                                 }
//                               }
//                               if (timeSlots.isEmpty) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: CustomText(
//                                     text: "No time slots available for this date",
//                                   ),
//                                 );
//                               }

//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomText(text: "Choose Time Slot"),
//                                   if (state.selectedTimeSlot == null &&
//                                       context.read<ServiceBookingBloc>().state.formError != null)
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 5),
//                                       child: CustomText(
//                                         text: context.read<ServiceBookingBloc>().state.formError!,
//                                         color: Colors.red,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   Container(
//                                     constraints: BoxConstraints(maxHeight: height * 0.20),
//                                     child: GridView.builder(
//                                       shrinkWrap: true,
//                                       physics: NeverScrollableScrollPhysics(),
//                                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                         childAspectRatio: 2.4,
//                                         crossAxisCount: 2,
//                                         mainAxisSpacing: 5,
//                                         crossAxisSpacing: 5,
//                                       ),
//                                       itemCount: timeSlots.length,
//                                       itemBuilder: (context, index) {
//                                         final slot = timeSlots[index];
//                                         bool isSelected = state.selectedTimeSlot == slot;
//                                         return GestureDetector(
//                                           onTap: () {
//                                             log("time slot tapped: $slot");
//                                             context.read<AddDateBloc>().add(
//                                                   TimeSlotSelectedEvent(timeSlot: slot),
//                                                 );
//                                             // Also update ServiceBookingBloc
//                                             context.read<ServiceBookingBloc>().add(
//                                                   TimeSlotSelected(selectedTimeSlot: slot),
//                                                 );
//                                           },
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(5),
//                                                 border: Border.all(
//                                                   color: isSelected
//                                                       ? Colors.teal
//                                                       : AppTheme.darkBorderColor,
//                                                   width: isSelected ? 2 : 1,
//                                                 ),
//                                                 color: isSelected
//                                                     ? Colors.teal.withAlpha(51)
//                                                     : null,
//                                               ),
//                                               child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.timer_outlined,
//                                                     color: isSelected
//                                                         ? Colors.teal
//                                                         : AppTheme.darkIconColor,
//                                                     size: 22,
//                                                   ),
//                                                   CustomText(
//                                                     text: slot,
//                                                     color: isSelected ? Colors.teal : null,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           )
//                         ],
//                       ),
//                     ),

//                     // Contact Number
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: CustomText(
//                         text: "Contact Number",
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SecondaryTextFeild(
//                       controller: contactController,
//                       hintText: "Enter contact number",
//                       onChanged: (value) {
//                         context.read<ServiceBookingBloc>().add(
//                               ContactNumberUpdated(contactNumber: value),
//                             );
//                       },
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 2),
//                       child: CustomText(
//                         maxLines: 4,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w300,
//                         color: AppTheme.darkTextColorSecondary,
//                         text: "We will send you the ticket on this number. If you do not have a WhatsApp number, please enter any other phone number.",
//                       ),
//                     ),

//                     // Email
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: CustomText(
//                         text: "Email",
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SecondaryTextFeild(
//                       controller: emailController,
//                       hintText: "Enter email address",
//                       onChanged: (value) {
//                         context.read<ServiceBookingBloc>().add(
//                               EmailUpdated(email: value),
//                             );
//                       },
//                     ),

//                     // Summary
//                     Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Container(
//                         width: double.infinity,
//                         height: height * 0.25,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: AppTheme.darkBorderColor),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             spacing: height * 0.008,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: height * 0.001),
//                               CustomText(
//                                 text: "Summary",
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               SizedBox(height: height * 0.01),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomText(text: serviceTitle),
//                                   CustomText(
//                                     text: "₹ ${totalAmount.toStringAsFixed(2)}",
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomText(text: "Platform Fee"),
//                                   CustomText(text: "₹ 0.00"),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomText(text: "GST on Platform Fee"),
//                                   CustomText(text: "₹ 0.00"),
//                                 ],
//                               ),
//                               Divider(
//                                 color: AppTheme.darkBorderColor,
//                                 thickness: 2,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomText(
//                                     text: "Total Amount",
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   CustomText(text: "₹ $totalAmount"),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),

//                     // Payment Button
//                     BlocBuilder<ServiceBookingBloc, ServiceBookingState>(
//                       builder: (context, state) {
//                         final addDateState = context.read<AddDateBloc>().state;
                        
//                         // Check if all required fields are filled
//                         final isFormComplete = state.selectedServiceId != null &&
//                             addDateState.selectedDate != null &&
//                             addDateState.selectedTimeSlot != null &&
//                             contactController.text.trim().isNotEmpty &&
//                             emailController.text.trim().isNotEmpty &&
//                             contactController.text.trim().length >= 10 &&
//                             RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text.trim());

//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: GestureDetector(
//                             onTap: state is ServiceBookingLoadingState ? null : _handlePaymentButtonPress,
//                             child: Container(
//                               width: double.infinity,
//                               height: height * 0.07,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: state is ServiceBookingLoadingState
//                                     ? Colors.grey[600]
//                                     : (isFormComplete ? Colors.blueAccent : Colors.grey),
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               child: state is ServiceBookingLoadingState
//                                   ? Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           width: 20,
//                                           height: 20,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2,
//                                             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                           ),
//                                         ),
//                                         SizedBox(width: 10),
//                                         CustomText(
//                                           text: "Processing...",
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ],
//                                     )
//                                   : CustomText(
//                                       text: "Pay ₹$totalAmount.00",
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }










