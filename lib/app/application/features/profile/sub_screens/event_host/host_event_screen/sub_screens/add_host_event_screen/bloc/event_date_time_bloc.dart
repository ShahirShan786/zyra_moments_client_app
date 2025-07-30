import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/event_date_time_event.dart';
import 'package:zyra_momments_app/app/application/features/profile/sub_screens/event_host/host_event_screen/sub_screens/add_host_event_screen/bloc/event_date_time_state.dart';
import 'package:zyra_momments_app/main.dart';

class EventDateTimeBloc extends Bloc<EventDateTimeEvent, EventDateTimeState> {
  EventDateTimeBloc() : super(const EventDateTimeState()) {
    on<PickEventDate>((event, emit) async {
      final picked = await showDatePicker(
        context: navigatorKey.currentContext!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (picked != null) {
        emit(state.copyWith(selectedDate: picked));
      }
    });

    on<PickStartTime>((event, emit) async {
      final picked = await showTimePicker(
        context: navigatorKey.currentContext!,
        initialTime: TimeOfDay.now(),
      );

      if (picked != null) {
        emit(state.copyWith(startTime: picked));
      }
    });

    on<PickEndTime>((event, emit) async {
      final picked = await showTimePicker(
        context: navigatorKey.currentContext!,
        initialTime: TimeOfDay.now(),
      );

      if (picked != null) {
        emit(state.copyWith(endTime: picked));
      }
    });
  }
}
