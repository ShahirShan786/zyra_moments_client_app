part of 'discover_bloc.dart';

sealed class DiscoverState extends Equatable {
  const DiscoverState();
  
  @override
  List<Object> get props => [];
}

final class DiscoverInitial extends DiscoverState {}


class DiscoverAnimating extends DiscoverState{
  final bool animate;

 const DiscoverAnimating({required this.animate});
   @override
  List<Object> get props => [animate];
}