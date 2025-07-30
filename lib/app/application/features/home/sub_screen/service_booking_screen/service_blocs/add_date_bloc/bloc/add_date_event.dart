part of 'add_date_bloc.dart';

sealed class AddDateEvent extends Equatable {
  const AddDateEvent();

  @override
  List<Object> get props => [];
}

class DateSelectEvent extends AddDateEvent{
  final DateTime selectedDate;

const  DateSelectEvent({required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}

class TimeSlotSelectedEvent extends AddDateEvent{
  final String timeSlot;

 const TimeSlotSelectedEvent({required this.timeSlot});
 @override
  List<Object> get props => [timeSlot];

  
}

class ClearDateEvent extends AddDateEvent {}