part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState{}

final class ProfileSuccessState extends ProfileState{
  final ClientModel user;

 const ProfileSuccessState(this.user);

   @override
  List<Object> get props => [user];
}


class ProfileFailueState extends ProfileState{
  final String errorMessage;

 const ProfileFailueState({required this.errorMessage});
     @override
  List<Object> get props => [errorMessage];
}

class ProfileImagePickState extends ProfileState{
  final File imageFile;

 const ProfileImagePickState(this.imageFile);
   @override
  List<Object> get props => [imageFile];
}


// for vendor update request

class VendorProfileUpdateLoadingState extends ProfileState{}

class VendorProfileUpdateSuccessState extends ProfileState{}

class VendorProfileUpdateFailureState extends ProfileState{
  final String errorMessage;

  const VendorProfileUpdateFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}