 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_details_screen/booking_details_screen.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/booking_status_screen/bloc/booking_status_bloc.dart';
import 'package:zyra_momments_app/app/data/models/service_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildBookingItem(
    BuildContext context,
    dynamic booking,
    int index,
    BookingStatusSuccessState state,
    
  ) {
    final serviceDetails = booking.serviceDetails;
    final timeSlot = booking.timeSlot;
    final vendor = booking.vendorId;
    final date = booking.bookingDate;
    final userDetails = booking.userId;
    final vendorDetails = booking.vendorId;
    final totalPrice = booking.totalPrice;
    final paymentId = booking.paymentId;
    final paymentStatus = booking.paymentStatus;
    final status = booking.status;
    final normalizedStatus = _normalizeStatus(status);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => _navigateToBookingDetails(
          context,
          serviceDetails,
          date,
          timeSlot,
          userDetails,
          vendorDetails,
          paymentId,
          paymentStatus,
          totalPrice,
          status,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.darkSecondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBookingInfoRow(context, serviceDetails, vendor, date, totalPrice, normalizedStatus),
                const SizedBox(height: 8),
                _buildStatusDropdown(context, normalizedStatus, state, index),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildBookingInfoRow(
    BuildContext context,
    dynamic serviceDetails,
    dynamic vendor,
    DateTime date,
    double totalPrice,
    String normalizedStatus,
  ) {
    final width = MediaQuery.of(context).size.width;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoLabels(),
        SizedBox(width: width * 0.02),
        _buildInfoValues(serviceDetails, vendor, date, totalPrice, normalizedStatus, width),
      ],
    );
  }

  Column _buildInfoLabels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Service", color: AppTheme.darkIconColor),
        CustomText(text: "Customer", color: AppTheme.darkIconColor),
        CustomText(text: "Date", color: AppTheme.darkIconColor),
        CustomText(text: "Price", color: AppTheme.darkIconColor),
        CustomText(text: "Status", color: AppTheme.darkIconColor),
      ],
    );
  }

  Column _buildInfoValues(
    dynamic serviceDetails,
    dynamic vendor,
    DateTime date,
    double totalPrice,
    String normalizedStatus,
    double width,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: ":   ${serviceDetails.serviceTitle}"),
        CustomText(text: ":   ${vendor.firstName}${vendor.lastName}"),
        CustomText(text: ":   ${DateFormat('dd-MM-yyyy').format(date)}"),
        CustomText(text: ":   ₹$totalPrice"),
        _buildStatusIndicator(normalizedStatus, width),
      ],
    );
  }

  Widget _buildStatusIndicator(String normalizedStatus, double width) {
    return Container(
      width: width * 0.25,
      height: width * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _getStatusColor(normalizedStatus),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getStatusIcon(normalizedStatus),
            color: AppTheme.darkTextColorSecondary,
            size: 15,
          ),
          const SizedBox(width: 4),
          CustomText(
            text: _getStatusText(normalizedStatus),
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown(
    BuildContext context,
    String normalizedStatus,
    BookingStatusSuccessState state,
    int index,
  ) {
    final width = MediaQuery.of(context).size.width;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: width * 0.38,
          height: width * 0.095,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.darkBorderColor),
            borderRadius: BorderRadius.circular(5),
            color: AppTheme.darkPrimaryColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: normalizedStatus,
              dropdownColor: AppTheme.darkPrimaryColor,
              style: TextStyle(color: AppTheme.darkTextColorSecondary),
              items: ['pending', 'completed', 'cancelled'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CustomText(text: value),
                );
              }).toList(),
              onChanged: (newValue) {
                _handleStatusChange(context, newValue, normalizedStatus, state, index);
              },
            ),
          ),
        ),
      ],
    );
  }


  // Helper methods
  String _normalizeStatus(String status) {
    const allowedStatuses = ['pending', 'completed', 'cancelled'];
    if (allowedStatuses.contains(status)) {
      return status;
    }
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'approved':
        return 'completed';
      case 'rejected':
      case 'declined':
        return 'cancelled';
      default:
        return 'pending';
    }
  }

   void _navigateToBookingDetails(
    BuildContext context,
    dynamic service,
    DateTime date,
    TimeSlot  time,
    dynamic user,
    dynamic vendor,
    String paymentId,
    String paymentStatus,
    double totalPrice,
    String status,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookingDetailsScreen(
          service: service,
          date: date,
          time: time,
          user: user,
          vendor: vendor,
          paymentId: paymentId,
          paymentSatus: paymentStatus,
          totalPrice: totalPrice.toInt(),
          status: status,
        ),
      ),
    );
  }

    Color _getStatusColor(String status) {
    if (status == 'completed') {
      return Colors.green.withAlpha(84);
    } else if (status == 'cancelled') {
      return Colors.red.withAlpha(84);
    } else {
      return Colors.amber.withAlpha(84);
    }
  }

  IconData _getStatusIcon(String status) {
    if (status == 'completed') {
      return Icons.check_circle_outline;
    } else if (status == 'cancelled') {
      return Icons.cancel_outlined;
    } else {
      return Icons.timer_outlined;
    }
  }

  String _getStatusText(String status) {
    if (status == 'completed') {
      return "succeeded";
    } else if (status == 'cancelled') {
      return "cancelled";
    } else {
      return "pending";
    }
  }

 

  void _handleStatusChange(
    BuildContext context,
    String? newValue,
    String currentStatus,
    BookingStatusSuccessState state,
    int index,
  ) {
    if (newValue != null && newValue != currentStatus) {
      context.read<BookingStatusBloc>().add(
        UpdatBookingStatusEvent(
          bookingId: state.bookings[index].id,
          status: newValue,
        ),
      );
    }
  }

