part of 'add_host_event_bloc.dart';

sealed class AddHostEventEvent extends Equatable {

  const AddHostEventEvent();

  @override
  List<Object?> get props => [];
}


class PickImageEvent extends AddHostEventEvent{

}


class RemoveImageEvent extends AddHostEventEvent{}

class UploadImageToColudineryEvent extends AddHostEventEvent{
  final File image;
const UploadImageToColudineryEvent( this.image);
}

class CreateHostEventEvent extends AddHostEventEvent {
  final HostEvent hostEvent;
  const CreateHostEventEvent(this.hostEvent);
  
  @override
  List<Object?> get props => [hostEvent];
}