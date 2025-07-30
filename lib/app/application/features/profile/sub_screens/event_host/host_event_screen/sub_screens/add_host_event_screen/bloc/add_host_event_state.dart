part of 'add_host_event_bloc.dart';

sealed class AddHostEventState extends Equatable {
  const AddHostEventState();
  
  @override
  List<Object> get props => [];
}

final class AddHostEventInitial extends AddHostEventState {}

class ImageSelectedLocal extends AddHostEventState{
  final File image;

const  ImageSelectedLocal(this.image);
}
class ImageUploadInProgress extends AddHostEventState {}

class ImageUploadedSuccess extends AddHostEventState {
  final String imageUrl;
  const ImageUploadedSuccess(this.imageUrl);
}

class ImageUploadFailure extends AddHostEventState {
  final String error;
  const ImageUploadFailure(this.error);
}

// Event creation states
class EventCreationInProgress extends AddHostEventState {}

class EventCreatedSuccess extends AddHostEventState {
  final String message; // or whatever success response you get
  const EventCreatedSuccess(this.message);
  
  @override
  List<Object> get props => [message];
}

class EventCreationFailure extends AddHostEventState {
  final String error;
  const EventCreationFailure(this.error);
  
  @override
  List<Object> get props => [error];
}