import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';

part 'add_date_event.dart';
part 'add_date_state.dart';

class AddDateBloc extends Bloc<AddDateEvent, AddDateState> {
  final ServiceBookingBloc serviceBookingBloc;

  AddDateBloc({required this.serviceBookingBloc}) : super(const AddDateState()) {
    on<DateSelectEvent>((event, emit) {
      emit(state.copyWith(
        selectedDate: event.selectedDate,
        selectedTimeSlot: null, // Clear time slot when date changes
      ));
      
      // Notify ServiceBookingBloc about date selection
      serviceBookingBloc.add(DateSelected(selectedDate: event.selectedDate));
    });

    on<TimeSlotSelectedEvent>((event, emit) {
      emit(state.copyWith(
        selectedTimeSlot: event.timeSlot,
      ));
      
      // Notify ServiceBookingBloc about time slot selection
      serviceBookingBloc.add(TimeSlotSelected(selectedTimeSlot: event.timeSlot));
    });

    on<ClearDateEvent>((event, emit) {
      emit(const AddDateState());
      
      // Clear date and time slot in ServiceBookingBloc as well
      // Pass null instead of empty string for DateTime
      serviceBookingBloc.add(DateSelected(selectedDate: null));
      serviceBookingBloc.add(const TimeSlotSelected(selectedTimeSlot: ''));
    });
  }
}


// // add_date_bloc.dart
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:intl/intl.dart';
// import 'package:zyra_momments_app/app/application/features/home/sub_screen/service_booking_screen/service_blocs/bloc/service_booking_bloc.dart';

// part 'add_date_event.dart';
// part 'add_date_state.dart';

// class AddDateBloc extends Bloc<AddDateEvent, AddDateState> {
//   final ServiceBookingBloc serviceBookingBloc;

//   AddDateBloc({required this.serviceBookingBloc}) : super(const AddDateState()) {
//     on<DateSelectEvent>((event, emit) {
//       emit(state.copyWith(
//         selectedDate: event.selectedDate,
//         selectedTimeSlot: null,
//       ));
//       serviceBookingBloc.add(ValidateForm(
//         selectedDate: DateFormat('yyyy-MM-dd').format(event.selectedDate),
//       ));
//     });

//     on<TimeSlotSelectedEvent>((event, emit) {
//       emit(state.copyWith(
//         selectedTimeSlot: event.timeSlot,
//       ));
//       serviceBookingBloc.add(ValidateForm(
//         selectedDate: state.selectedDate != null
//             ? DateFormat('yyyy-MM-dd').format(state.selectedDate!)
//             : null,
//         selectedTimeSlot: event.timeSlot,
//       ));
//     });

//     on<ClearDateEvent>((event, emit) {
//       emit(const AddDateState());
//       serviceBookingBloc.add(const ValidateForm());
//     });
//   }
// }








// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'add_date_event.dart';
// part 'add_date_state.dart';

// class AddDateBloc extends Bloc<AddDateEvent, AddDateState> {
//   AddDateBloc() : super(AddDateState()) {
//     on<DateSelectEvent>((event, emit) {
//       emit(state.copyWith(selectedDate: event.selectedDate));
//     });

//       on<TimeSlotSelectedEvent>((event, emit) {
//       emit(state.copyWith(selectedTimeSlot: event.timeSlot));
//     });

//       on<ClearDateEvent>((event, emit) {
//       emit(const AddDateState());
//     });
//   }
// }
