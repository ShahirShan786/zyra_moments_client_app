part of 'add_date_bloc.dart';

 class AddDateState extends Equatable {
 final DateTime? selectedDate;
 final String? selectedTimeSlot;
  const AddDateState({this.selectedDate , this.selectedTimeSlot});

  AddDateState copyWith({
  DateTime? selectedDate,
  String? selectedTimeSlot,
}){
  return AddDateState(
    selectedDate : selectedDate ?? this.selectedDate,
    selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot
  );
}
  
  @override
  List<Object?> get props => [selectedDate , selectedTimeSlot];
}



final class AddDateInitial extends AddDateState {}
