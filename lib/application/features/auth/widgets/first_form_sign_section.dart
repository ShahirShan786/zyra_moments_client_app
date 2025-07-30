import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';

class FirstSignFormSection extends StatelessWidget {
  const FirstSignFormSection({
    super.key,
    required this.height,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
  });

  final double height;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 15, vertical: 12),
      child: Container(
        width: double.infinity,
        height: height * 0.48,
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    AppTheme.darkBorderColor),
            borderRadius:
                BorderRadius.circular(8)),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Join our Vendor Network",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight:
                      FontWeight.w800),
            ),
            CustomText(
              text:
                  "Start selling your product today",
              fontSize: 15,
              FontFamily: 'roboto',
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15),
              child: Align(
                  alignment:
                      Alignment.centerLeft,
                  child: CustomText(
                    text: "First Name",
                  )),
            ),
            CustomTextField(
              controller: firstNameController,
              hintText:
                  "Enter your fist name",
             validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First name cannot be empty';
                } else if (value.length < 4) {
                  return 'First name must be at least 3 characters long';
                } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                  return 'First name can only contain letters, numbers, and underscores';
                }
                return null;
              },
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15),
              child: Align(
                  alignment:
                      Alignment.centerLeft,
                  child: CustomText(
                    text: "Last Name",
                    // fontSize: 13,
                  )),
            ),
            CustomTextField(
              controller: lastNameController,
              hintText:
                  "Enter your last name",
           validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Last name cannot be empty';
                } else if (value.trim().length < 2) {
                  return 'Last name must be at least 3 characters long';
                } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value.trim())) {
                  return 'Last name can only contain letters and spaces';
                }
                return null;
              },
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15),
              child: Align(
                  alignment:
                      Alignment.centerLeft,
                  child: CustomText(
                    text: "Phone Number",
                    // fontSize: 13,
                    // ****************************************************************************************
                  )),
            ),
            CustomTextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType:
                  TextInputType.phone,
              hintText:
                  "Enter your Phone number",
              validator: (value) {
                if (value == null ||
                    value.isEmpty) {
                  return 'Phone number cannot be empty';
                } else if (!RegExp(
                        r'^[0-9]{10,15}$')
                    .hasMatch(value)) {
                  return 'Enter a valid phone number (10-15 digits)';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}