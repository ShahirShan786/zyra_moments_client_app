import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/data/models/attendies_response_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/host_event_usecases.dart';

part 'host_request_event.dart';
part 'host_request_state.dart';

class HostRequestBloc extends Bloc<HostRequestEvent, HostRequestState> {
  final HostEventUsecases hostEventUsecases = HostEventUsecases();
  HostRequestBloc() : super(HostRequestInitial()) {
    on<HostFundRequest>((event, emit) async {
      emit(HostRequestLoading());

      final result = await hostEventUsecases.requestToFundRelease(
          event.eventId, event.message);

      result.fold((failure) {
        emit(HostRequestFailure(errorMessage: failure.message));
      }, (success) {
        emit(HostRequestSuccess());
      });
    });

    on<AttendiesDetailsRequest>((event, emit) async {
      emit(AttendiesDataLoading());

      final result = await hostEventUsecases.getAllAttendiesList(event.eventId);

      result.fold((failure) {
        emit(AttendiesDataFailure(errorMessage: failure.message));
      }, (attendiesList) {
        emit(AttendiesDataLoaded(attendiesData: attendiesList.data!));
      });
    });
  }
}
