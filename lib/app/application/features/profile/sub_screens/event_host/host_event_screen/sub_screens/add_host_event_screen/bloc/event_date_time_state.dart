import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventDateTimeState extends Equatable {
  final DateTime? selectedDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  const EventDateTimeState({
    this.selectedDate,
    this.startTime,
    this.endTime,
  });

  EventDateTimeState copyWith({
    DateTime? selectedDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return EventDateTimeState(
      selectedDate: selectedDate ?? this.selectedDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [selectedDate, startTime, endTime];
}
