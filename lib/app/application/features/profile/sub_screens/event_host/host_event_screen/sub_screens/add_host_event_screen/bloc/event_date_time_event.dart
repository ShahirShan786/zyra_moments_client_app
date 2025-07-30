import 'package:equatable/equatable.dart';

abstract class EventDateTimeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickEventDate extends EventDateTimeEvent {}

class PickStartTime extends EventDateTimeEvent {}

class PickEndTime extends EventDateTimeEvent {}
