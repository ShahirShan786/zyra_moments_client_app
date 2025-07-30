import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/domain/usecases/vendor_profile_usecases.dart';
import 'package:zyra_momments_app/data/models/vendor_category_model.dart';

part 'best_vendor_event.dart';
part 'best_vendor_state.dart';

class BestVendorBloc extends Bloc<BestVendorEvent, BestVendorState> {
  final VendorProfileUsecases vendorProfileUsecases = VendorProfileUsecases();
  BestVendorBloc() : super(BestVendorInitial()) {
    on<BestVendorEvent>((event, emit) {
      // TODO: implement event handler
    });

    // For getting best venodrs
    on<GetBestVendorRequestEvent>((event, emit) async {
      emit(GetBestvendorLoadingState());

      final result = await vendorProfileUsecases.getBestVenoders();

      result.fold((failure) {
        emit(GetBestvendorFailureState(errorMessage: failure.message));
      }, (bestVendors) {
        emit(GetBestVenodorSuccessState(bestVendors: bestVendors));
      });
    });
  }
}
