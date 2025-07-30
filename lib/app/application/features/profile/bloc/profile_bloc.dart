import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/client_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/client_profile_usecases.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ClientProfileUsecases clientProfileUsecases = ClientProfileUsecases();
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());

      final result = await clientProfileUsecases.getClientProfileDetails();

      result.fold((failure) {
        emit(ProfileFailueState(errorMessage: failure.message));
      }, (user) {
        log("User details received in profile bloc: $user");
        emit(ProfileSuccessState(user));
      });
    });

    on<PickProfileImageEvent>((event, emit) {
      emit(ProfileImagePickState(event.imageFile));
    });

    on<UpdateClientProfileEvent>((event, emit) async {
      try {
        emit(ProfileLoadingState());

        // Store the image file locally
        final File? imageFile = event.imageFile;
        String? uploadedImageUrl;

        // Only attempt to upload if an image is provided
        if (imageFile != null) {
          try {
            // Add a timeout to prevent potential infinite loops
            uploadedImageUrl = await clientProfileUsecases
                .uploadImageToCloudinery(imageFile)
                .timeout(const Duration(seconds: 30));
            log("UploadImagUrl is :$uploadedImageUrl");
          } catch (e) {
            log("Image upload error: $e");
            emit(VendorProfileUpdateFailureState(
                errorMessage: "Image upload failed: $e"));
            return;
          }
        }

        // Create a new request object with the image URL (if available)
        final updateRequest = UpdateClientRequest(
            firstName: event.request.firstName,
            lastName: event.request.lastName,
            phoneNumber: event.request.phoneNumber,
            place: event.request.place,
            profileImage: uploadedImageUrl);

        // Update the profile with the request
        final result =
            await clientProfileUsecases.updateClientProfileRequest(updateRequest);

        result.fold((failure) {
          log("Profile update failed: ${failure.message}");
          emit(VendorProfileUpdateFailureState(errorMessage: failure.message));
        }, (data) {
          log("Profile updated successfully");
          emit(VendorProfileUpdateSuccessState());
          // Refresh profile data after successful update
          add(FetchProfileEvent());
        });
      } catch (e) {
        log("Unexpected error in update: $e");
        emit(VendorProfileUpdateFailureState(
            errorMessage: "An unexpected error occurred: $e"));
      }
    });
  }
}
