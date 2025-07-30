import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/add_host_event_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/event_date_time_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/event_date_time_event.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/event_date_time_state.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/map_bloc.dart';
import 'package:zyra_momments_app/app/data/models/host_event.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';
import 'package:zyra_momments_app/application/config/widgets/custom_snackbars.dart';
import 'package:zyra_momments_app/application/config/widgets/primary_button.dart';
import 'package:zyra_momments_app/application/config/widgets/text_form_field.dart';

class AddHostEventScreen extends StatefulWidget {
  const AddHostEventScreen({super.key});

  @override
  State<AddHostEventScreen> createState() => _AddHostEventScreenState();
}

class _AddHostEventScreenState extends State<AddHostEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final ticketLimitController = TextEditingController();

  // Store current map coordinates
  LatLng? currentCoordinates;
  String? uploadedImageUrl;

  @override
  void dispose() {
    locationController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    ticketLimitController.dispose();
    super.dispose();
  }

  // Validation methods
  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    final price = double.tryParse(value);
    if (price == null || price < 0) {
      return 'Please enter a valid price';
    }
    return null;
  }

  String? _validateTicketLimit(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ticket limit is required';
    }
    final limit = int.tryParse(value);
    if (limit == null || limit <= 0) {
      return 'Please enter a valid ticket limit';
    }
    return null;
  }

  // Collect and validate all form data
  bool _validateAllFields() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    // Check date/time selection
    final dateTimeState = context.read<EventDateTimeBloc>().state;
    if (dateTimeState.selectedDate == null) {
      _showErrorSnackBar('Please select event date');
      return false;
    }
    if (dateTimeState.startTime == null) {
      _showErrorSnackBar('Please select start time');
      return false;
    }
    if (dateTimeState.endTime == null) {
      _showErrorSnackBar('Please select end time');
      return false;
    }

    // Check if location has been searched and coordinates are available
    if (currentCoordinates == null) {
      _showErrorSnackBar('Please search for a valid location');
      return false;
    }

    // Check if image is uploaded
    if (uploadedImageUrl == null) {
      _showErrorSnackBar('Please upload a poster image');
      return false;
    }

    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Create HostEvent object from form data
  HostEvent _createHostEventObject() {
    final dateTimeState = context.read<EventDateTimeBloc>().state;

    return HostEvent(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      eventLocation: locationController.text.trim(),
      posterImage: uploadedImageUrl!,
      date: dateTimeState.selectedDate!,
      startTime: dateTimeState.startTime!.format(context),
      endTime: dateTimeState.endTime!.format(context),
      pricePerTicket: (double.parse(priceController.text) * 100)
          .toInt(), // Convert to cents
      ticketLimit: int.parse(ticketLimitController.text),
      coordinates: Coordinates(
        type: "Point",
        coordinates: [
          currentCoordinates!.longitude,
          currentCoordinates!.latitude
        ],
      ),
    );
  }

  // Handle event creation - Updated to use BLoC
  void _handleCreateEvent() async {
    if (!_validateAllFields()) {
      return;
    }

    try {
      final hostEvent = _createHostEventObject();
      
      // Use the BLoC to create the event
      context.read<AddHostEventBloc>().add(CreateHostEventEvent(hostEvent));
      
    } catch (e) {
      _showErrorSnackBar('Failed to create event: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            // Image upload listener
            BlocListener<AddHostEventBloc, AddHostEventState>(
              listener: (context, state) {
                if (state is ImageUploadedSuccess) {
                  uploadedImageUrl = state.imageUrl;
                  showSuccessSnackbar(
                    context: context,
                    height: height,
                    title: "Image uploaded successfully!",
                    body: "",
                  );
                } else if (state is ImageUploadFailure) {
                  log(state.error);
                  _showErrorSnackBar('Image upload failed: ${state.error}');
                }
              },
            ),
            // Event creation listener
            BlocListener<AddHostEventBloc, AddHostEventState>(
              listener: (context, state) {
                if (state is EventCreationInProgress) {
                  // Show loading dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is EventCreatedSuccess) {
                  // Close loading dialog
                  Navigator.of(context).pop();
                  
                  // Show success and navigate back
                  _showSuccessSnackBar(state.message);
                  Navigator.of(context).pop(); // Go back to previous screen
                  
                } else if (state is EventCreationFailure) {
                  // Close loading dialog if open
                  Navigator.of(context).pop();
                  _showErrorSnackBar('Failed to create event: ${state.error}');
                }
              },
            ),
          ],
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.01),
                  CustomText(
                    text: "Create New Event",
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: height * 0.01),

                  // Title Field
                  CustomText(
                    text: "Title",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  SecondaryTextFeild(
                    controller: titleController,
                    hintText: "Enter your event title",
                    validator: _validateTitle,
                  ),
                  SizedBox(height: height * 0.01),

                  // Description Field
                  CustomText(
                    text: "Description",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  SecondaryTextFeild(
                    controller: descriptionController,
                    hintText: "Description",
                    maxLines: 5,
                    validator: _validateDescription,
                  ),
                  SizedBox(height: height * 0.01),

                  // Date and Time Section
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: BlocBuilder<EventDateTimeBloc, EventDateTimeState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Date",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SecondaryTextFeild(
                                    onTap: () => context
                                        .read<EventDateTimeBloc>()
                                        .add(PickEventDate()),
                                    readOnly: true,
                                    hintText: state.selectedDate != null
                                        ? DateFormat('yyyy-MM-dd')
                                            .format(state.selectedDate!)
                                        : "Select Date",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Start Time",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SecondaryTextFeild(
                                    readOnly: true,
                                    onTap: () => context
                                        .read<EventDateTimeBloc>()
                                        .add(PickStartTime()),
                                    hintText: state.startTime != null
                                        ? state.startTime!.format(context)
                                        : "Select Time",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "End Time",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SecondaryTextFeild(
                                    readOnly: true,
                                    onTap: () => context
                                        .read<EventDateTimeBloc>()
                                        .add(PickEndTime()),
                                    hintText: state.endTime != null
                                        ? state.endTime!.format(context)
                                        : "Select Time",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  // Price and Ticket Limit Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Price per ticket",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              SecondaryTextFeild(
                                controller: priceController,
                                hintText: "0.00",
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                validator: _validatePrice,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Ticket limit",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              SecondaryTextFeild(
                                controller: ticketLimitController,
                                hintText: "100",
                                keyboardType: TextInputType.number,
                                validator: _validateTicketLimit,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Location and Map Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: BlocProvider(
                      create: (context) => MapBloc(),
                      child: BlocListener<MapBloc, MapState>(
                        listener: (context, state) {
                          if (state is MapLoaded) {
                            currentCoordinates = state.position;
                            print("Coordinates updated: ${state.position}");
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width * 0.60,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Event Location",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SecondaryTextFeild(
                                        controller: locationController,
                                        hintText: "Enter Location",
                                        validator: _validateLocation,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      final mapBloc =
                                          BlocProvider.of<MapBloc>(context);
                                      return GestureDetector(
                                        onTap: () {
                                          String locationText =
                                              locationController.text.trim();
                                          if (locationText.isNotEmpty) {
                                            mapBloc.add(SearchLoacationEvent(
                                                location: locationText));
                                          } else {
                                            _showErrorSnackBar(
                                                "Please enter a location first");
                                          }
                                        },
                                        child: Container(
                                          height: 48,
                                          margin: const EdgeInsets.only(left: 8),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.location_on,
                                                  color: Colors.white),
                                              SizedBox(width: 4),
                                              Text(
                                                "Search",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            _buildMapSection(height),
                            CustomText(
                              text:
                                  "Check the map and confirm the event location, or search by address.",
                              fontSize: 15,
                              color: AppTheme.darkTextLightColor,
                            ),

                            // Image Upload Section
                            CustomText(
                              text: "Poster image",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: height * 0.01),
                            BlocBuilder<AddHostEventBloc, AddHostEventState>(
                              builder: (context, state) {
                                if (state is AddHostEventInitial ||
                                    state is ImageUploadFailure) {
                                  return GestureDetector(
                                    onTap: () => context
                                        .read<AddHostEventBloc>()
                                        .add(PickImageEvent()),
                                    child: Container(
                                      width: width * 0.15,
                                      height: height * 0.070,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppTheme.darkBorderColor),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.darkTextColorSecondary,
                                      ),
                                    ),
                                  );
                                } else if (state is ImageUploadInProgress) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is ImageUploadedSuccess) {
                                  return Stack(
                                    children: [
                                      Image.network(
                                        state.imageUrl,
                                        height: height * 0.25,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(Icons.remove_circle,
                                              color: Colors.red),
                                          onPressed: () {
                                            uploadedImageUrl = null;
                                            context
                                                .read<AddHostEventBloc>()
                                                .add(PickImageEvent());
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            SizedBox(height: height * 0.02),

                            // Action Buttons
                            PrimaryButton(
                              label: "Create Event",
                              ontap: _handleCreateEvent,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  width: double.infinity,
                                  height: height * 0.055,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: AppTheme.darkTextColorSecondary),
                                  ),
                                  child: CustomText(
                                    text: "Cancel",
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapSection(double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: height * 0.25,
                width: double.infinity,
                color: Colors.white,
              ),
            );
          } else if (state is MapLoaded) {
            return SizedBox(
              height: height * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: state.position,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("location_marker"),
                      position: state.position,
                      infoWindow: InfoWindow(
                        title: state.isSearchResult
                            ? "Searched Location"
                            : "Default Location",
                      ),
                    )
                  },
                  onMapCreated: (GoogleMapController controller) {
                    controller
                        .animateCamera(CameraUpdate.newLatLng(state.position));
                  },
                ),
              ),
            );
          } else if (state is MapError) {
            return SizedBox(
              height: height * 0.25,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<MapBloc>(context)
                            .add(const LoadInitialLocationEvent());
                      },
                      child: const Text("Reset to Default Location"),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}