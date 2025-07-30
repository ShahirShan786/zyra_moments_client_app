part of 'evet_details_bloc.dart';

sealed class EvetDetailsEvent extends Equatable {
  const EvetDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadEventLocationEvent extends EvetDetailsEvent{
  final String placeName;

const  LoadEventLocationEvent({required this.placeName});


  @override
  List<Object> get props => [placeName];
}
