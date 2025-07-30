  import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:intl/intl.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/add_date_bloc/bloc/add_date_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';

Widget buildDatePickerSection(double width, double height , TextEditingController dateController, List<Service> services , List<DateTime> availableDates ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: "Pick Available date",
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        BlocBuilder<AddDateBloc, AddDateState>(
          builder: (context, state) {
            if (state.selectedDate != null) {
              dateController.text = DateFormat('dd-MM-yyyy').format(state.selectedDate!);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecondaryTextFeild(
                  controller: dateController,
                  readOnly: true,
                  hintText: "Pick date",
                  onTap: () => _selectDate(context , availableDates ,services , dateController ),
                ),
                if (state.selectedDate == null &&
                    context.read<ServiceBookingBloc>().state.formError != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      text: context.read<ServiceBookingBloc>().state.formError!,
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context , List<DateTime> availableDates , List<Service> services , TextEditingController dateController,) async {
    final selectedServiceId = context.read<ServiceBookingBloc>().state.selectedServiceId;

    if (selectedServiceId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a service first')),
      );
      return;
    }

    final selectedService = services.firstWhere((service) => service.id == selectedServiceId);
    availableDates = selectedService.availableDates.map((availableDate) => availableDate.date).toList();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    availableDates = availableDates.where((date) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      return !dateOnly.isBefore(today);
    }).toList();

    if (availableDates.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No upcoming available dates found')),
      );
      return;
    }

    availableDates.sort();

    try {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: availableDates.first,
        firstDate: availableDates.first,
        lastDate: availableDates.last,
        selectableDayPredicate: (date) => availableDates.any((d) =>
            d.year == date.year && d.month == date.month && d.day == date.day),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.teal,
              onPrimary: Colors.white,
              surface: AppTheme.darkSecondaryColor,
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.black),
          ),
          child: child!,
        ),
      );

      if (pickedDate != null) {
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        context.read<AddDateBloc>().add(DateSelectEvent(selectedDate: pickedDate));
        context.read<ServiceBookingBloc>().add(DateSelected(selectedDate: pickedDate));
      }
    } catch (e) {
      log("Date picker error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting date: $e')),
      );
    }
  }