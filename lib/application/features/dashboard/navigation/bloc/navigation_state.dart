part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  final NavigationTab selectedTab;
  const NavigationState(this.selectedTab);
  
  @override
  List<Object> get props => [selectedTab];
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial() : super(NavigationTab.home); 
}

final class NavigationStateSelected extends NavigationState {
  const NavigationStateSelected(super.tab);  
}