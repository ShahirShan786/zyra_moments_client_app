import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zyra_momments_app/app/application/features/profile/bloc/profile_bloc.dart';
import 'package:zyra_momments_app/app/data/models/client_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';


class ProfileUpdateScreen extends StatefulWidget {
  final String vendorId;
  const ProfileUpdateScreen({super.key, required this.vendorId});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  File? _pickedImage;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      BlocProvider.of<ProfileBloc>(context).add(
        PickProfileImageEvent(File(pickedFile.path)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppTheme.darkTextColorSecondary,
            )),
        title: CustomText(
          text: "Edit Profile",
          fontSize: 25,
          FontFamily: 'shafarik',
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is VendorProfileUpdateSuccessState) {
            showSuccessSnackbar(
                context: context,
                height: height,
                title: "Profile updated successfully",
                body: "profile has been updated");
            Navigator.of(context).pop();
          } else if (state is VendorProfileUpdateFailureState) {
            showFailureScackbar(
                context: context,
                height: height,
                title: "Failed to update profile",
                body: "Failed to update profile");
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    child: Stack(
                      children: [
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileImagePickState) {
                              _pickedImage = state.imageFile;
                              return GestureDetector(
                                onTap: () => _pickImage(context),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: AppTheme.darkSecondaryColor,
                                  backgroundImage: FileImage(state.imageFile),
                                ),
                              );
                            }
                            // Default avatar when no image is picked
                            return GestureDetector(
                              onTap: () => _pickImage(context),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: AppTheme.darkSecondaryColor,
                                child: Icon(
                                  Icons.person,
                                  color: AppTheme.darkIconColor,
                                  size: 60,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _pickImage(context),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: AppTheme.darkPrimaryColor,
                                child: Icon(
                                  Icons.mode_edit_outline_outlined,
                                  color: AppTheme.darkIconColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.030,
                  ),
                  Container(
                    width: double.infinity,
                    height: height * 0.66,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.darkBorderColor,
                        )),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: "First Name")),
                          ),
                          CustomTextField(
                            controller: _firstNameController,
                            hintText: " ",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First name cannot be empty';
                              } else if (value.length < 4) {
                                return 'First name must be at least 3 characters long';
                              } else if (!RegExp(r'^[a-zA-Z0-9_]+$')
                                  .hasMatch(value)) {
                                return 'First name can only contain letters, numbers, and underscores';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: "Last Name")),
                          ),
                          CustomTextField(
                            controller: _lastNameController,
                            hintText: " ",
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Last name cannot be empty';
                              } else if (value.trim().length < 2) {
                                return 'Last name must be at least 3 characters long';
                              } else if (!RegExp(r"^[a-zA-Z\s]+$")
                                  .hasMatch(value.trim())) {
                                return 'Last name can only contain letters and spaces';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  text: "Contact Number",
                                )),
                          ),
                          CustomTextField(
                            controller: _phoneNumberController,
                            hintText: " ",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number cannot be empty';
                              } else if (!RegExp(r'^[0-9]{10,15}$')
                                  .hasMatch(value)) {
                                return 'Enter a valid phone number (10-15 digits)';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(text: "Place")),
                          ),
                          CustomTextField(
                            controller: _placeController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a place';
                              }
                              if (value.trim().length < 3) {
                                return 'Place name must be at least 3 characters';
                              }
                              return null; // Valid input
                            },
                            hintText: " ",
                          ),
                          SizedBox(
                            height: height * 0.07,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BlocBuilder<ProfileBloc, ProfileState>(
                                    builder: (context, state) {
                                      bool isLoading =
                                          state is ProfileLoadingState;

                                      return GestureDetector(
                                        onTap: isLoading
                                            ? null
                                            : () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (_pickedImage == null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Please select a profile image"),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ));
                                                    return;
                                                  }

                                                  final firstName =
                                                      _firstNameController.text;
                                                  final lastName =
                                                      _lastNameController.text;
                                                  final phoneNumber =
                                                      _phoneNumberController
                                                          .text;
                                                  final place =
                                                      _placeController.text;

                                                  final request =
                                                      UpdateClientRequest(
                                                    firstName: firstName,
                                                    lastName: lastName,
                                                    phoneNumber: phoneNumber,
                                                    place: place,
                                                  );
                                                  log("Save Button taped");
                                                  context.read<ProfileBloc>().add(
                                                      UpdateClientProfileEvent(
                                                          request: request,
                                                          imageFile:
                                                              _pickedImage));
                                                }
                                              },
                                        child: Container(
                                          width: width * 0.40,
                                          height: height * 0.060,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppTheme
                                                  .darkTextColorSecondary,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: isLoading
                                              ? SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        AppTheme.darkBlackColor,
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : CustomText(
                                                  text: "Save",
                                                  color:
                                                      AppTheme.darkBlackColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: width * 0.40,
                                      height: height * 0.060,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppTheme.darkBorderColor),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: CustomText(
                                        text: "Close",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
