 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/add_date_bloc/bloc/add_date_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_state.dart';
import 'package:zyra_momments_app/app/data/models/vendor_profile_model.dart';

import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildServiceDropdown(double width, double height , List<Service> services ,TextEditingController dateController ,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            text: "Choose Service",
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppTheme.darkBoxColor,
            ),
            child: BlocBuilder<ServiceBookingBloc, ServiceBookingState>(
              builder: (context, state) {
                final availableServiceIds = services
                    .map((service) => service.id)
                    .toSet()
                    .toList();
                final validSelectedServiceId = availableServiceIds
                    .contains(state.selectedServiceId)
                    ? state.selectedServiceId
                    : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      hint: CustomText(text: "Select category"),
                      value: validSelectedServiceId,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      dropdownColor: AppTheme.darkPrimaryVarientColor,
                      focusColor: Colors.yellow,
                      borderRadius: BorderRadius.circular(8),
                      decoration: InputDecoration(border: InputBorder.none),
                      items:services.map((service) {
                        return DropdownMenuItem<String>(
                          value: service.id,
                          child: CustomText(text: service.serviceTitle),
                        );
                      }).toList(),
                      onChanged: (value) => _onServiceSelected(context, value , services , dateController,),
                    ),
                    if (state.selectedServiceId == null && state.formError != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomText(
                          text: state.formError!,
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _onServiceSelected(BuildContext context, String? value , List<Service> services ,TextEditingController dateController,
 ) {
    if (value != null) {
      final selectedService = services.firstWhere((service) => service.id == value);
      context.read<ServiceBookingBloc>().add(
        ServiceSelected(
          selectedServiceId: value,
          vendorId: selectedService.vendorId,
          totalAmount: selectedService.servicePrice,
        ),
      );
      context.read<AddDateBloc>().add(ClearDateEvent());
      dateController.clear();
    }
  }