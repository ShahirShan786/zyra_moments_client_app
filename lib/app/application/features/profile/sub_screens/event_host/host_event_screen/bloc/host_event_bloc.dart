import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/host_event_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/host_event_usecases.dart';

part 'host_event_event.dart';
part 'host_event_state.dart';

class HostEventBloc extends Bloc<HostEventEvent, HostEventState> {
  final HostEventUsecases hostEventUsecases = HostEventUsecases();
  HostEventBloc() : super(HostEventInitial()) {
    on<GetHostEventListRequest>((event, emit) async{
       emit(GetHostEventListLoadingState());

       final result = await hostEventUsecases.getAllHostedEvent();

       result.fold((failure){
        emit(GetHostEventFailureState(errorMessage: failure.message));
       }, (data){
        emit(GetHostEventListSuccessState(hostEventList: data.events));
       });
    });
  }
}
