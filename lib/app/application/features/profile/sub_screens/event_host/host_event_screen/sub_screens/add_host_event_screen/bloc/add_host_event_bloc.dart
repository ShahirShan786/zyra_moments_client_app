import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zyra_momments_app/app/data/models/host_event.dart';
import 'package:zyra_momments_app/app/domain/usecases/host_event_usecases.dart';

part 'add_host_event_event.dart';
part 'add_host_event_state.dart';

class AddHostEventBloc extends Bloc<AddHostEventEvent, AddHostEventState> {
  final HostEventUsecases hostEventUsecases = HostEventUsecases();
    final ImagePicker picker = ImagePicker();

  AddHostEventBloc() : super(AddHostEventInitial()) {
    on<PickImageEvent>((event, emit) async{
       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(ImageSelectedLocal(File(pickedFile.path)));
        add(UploadImageToColudineryEvent(File(pickedFile.path)));
      }
    });

    on<UploadImageToColudineryEvent>((event , emit)async{
        emit(ImageUploadInProgress());
      final  result = await hostEventUsecases.uploadImageToCloudinery(event.image);

      result.fold((failure){
        emit(ImageUploadFailure(failure.message));
      }, (url){
        emit(ImageUploadedSuccess(url));
      });
    });

      on<CreateHostEventEvent>((event, emit) async {
      emit(EventCreationInProgress());
      try {
        final result = await hostEventUsecases.createEvent(event.hostEvent);
        
        result.fold(
          (failure) => emit(EventCreationFailure(failure.message)),
          (success) => emit(EventCreatedSuccess(success)),
        );
      } catch (e) {
        emit(EventCreationFailure('Failed to create event: ${e.toString()}'));
      }
    });
  }
}
