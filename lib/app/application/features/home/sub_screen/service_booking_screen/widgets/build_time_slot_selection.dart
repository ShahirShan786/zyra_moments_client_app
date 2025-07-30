import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/add_date_bloc/bloc/add_date_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildTimeSlotSection(double height , List<Service> services) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      constraints: BoxConstraints(minHeight: height * 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AddDateBloc, AddDateState>(
            builder: (context, state) {
              if (state.selectedDate == null) return SizedBox.shrink();
              
              final timeSlots = _getAvailableTimeSlots(state.selectedDate! , services);
              if (timeSlots.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomText(text: "No time slots available for this date"),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Choose Time Slot"),
                  if (state.selectedTimeSlot == null &&
                      context.read<ServiceBookingBloc>().state.formError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: CustomText(
                        text: context.read<ServiceBookingBloc>().state.formError!,
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  _buildTimeSlotGrid(timeSlots, state.selectedTimeSlot , context),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  List<String> _getAvailableTimeSlots(DateTime selectedDate , List<Service> services) {
    List<String> timeSlots = [];
    for (var service in services) {
      for (var availableDates in service.availableDates) {
        if (availableDates.date.year == selectedDate.year &&
            availableDates.date.month == selectedDate.month &&
            availableDates.date.day == selectedDate.day) {
          timeSlots.addAll(availableDates.timeSlots
              .map((e) => "${e.startTime} - ${e.endTime}"));
        }
      }
    }
    return timeSlots;
  }

  Widget _buildTimeSlotGrid(List<String> timeSlots, String? selectedTimeSlot , BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2.4,
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          final slot = timeSlots[index];
          bool isSelected = selectedTimeSlot == slot;
          return GestureDetector(
            onTap: () => _onTimeSlotSelected(context, slot),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: isSelected ? Colors.teal : AppTheme.darkBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  color: isSelected ? Colors.teal.withAlpha(51) : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: isSelected ? Colors.teal : AppTheme.darkIconColor,
                      size: 22,
                    ),
                    CustomText(
                      text: slot,
                      color: isSelected ? Colors.teal : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTimeSlotSelected(BuildContext context, String slot) {
    log("time slot tapped: $slot");
    context.read<AddDateBloc>().add(TimeSlotSelectedEvent(timeSlot: slot));
    context.read<ServiceBookingBloc>().add(TimeSlotSelected(selectedTimeSlot: slot));
  }