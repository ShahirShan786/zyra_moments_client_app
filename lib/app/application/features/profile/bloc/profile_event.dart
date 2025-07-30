part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileEvent extends ProfileEvent {}

class PickProfileImageEvent extends ProfileEvent {
  final File imageFile;

  const PickProfileImageEvent(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}



class UpdateClientProfileEvent extends ProfileEvent {
  final UpdateClientRequest request;
  final File? imageFile;

  const UpdateClientProfileEvent({
    required this.request,
    required this.imageFile,
  });

  @override
  List<Object> get props => [request, imageFile ?? " "];
}
