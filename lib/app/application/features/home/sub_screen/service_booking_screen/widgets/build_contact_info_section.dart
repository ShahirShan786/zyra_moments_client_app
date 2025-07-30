import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';

Widget buildContactInfoSection(
    BuildContext context,
    TextEditingController contactController,
    TextEditingController emailController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          text: "Contact Number",
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      SecondaryTextFeild(
        controller: contactController,
        keyboardType: TextInputType.number,
        maxLength: 10,
        hintText: "Enter contact number",
        onChanged: (value) {
          context.read<ServiceBookingBloc>().add(
                ContactNumberUpdated(contactNumber: value),
              );
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: CustomText(
          maxLines: 4,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: AppTheme.darkTextColorSecondary,
          text:
              "We will send you the ticket on this number. If you do not have a WhatsApp number, please enter any other phone number.",
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          text: "Email",
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      SecondaryTextFeild(
        controller: emailController,
        hintText: "Enter email address",
        onChanged: (value) {
          context.read<ServiceBookingBloc>().add(
                EmailUpdated(email: value),
              );
        },
      ),
    ],
  );
}
