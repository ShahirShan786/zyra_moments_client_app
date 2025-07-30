  import 'package:flutter/widgets.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';

Widget buildEmailField(TextEditingController logEmailController) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: CustomText(text: "Email"),
          ),
        ),
        CustomTextField(
          controller: logEmailController,
          hintText: "Enter your email..",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email is required";
            }
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }