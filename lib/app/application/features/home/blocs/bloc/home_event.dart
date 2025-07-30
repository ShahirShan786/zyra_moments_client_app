part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class GetCategoryRequestEvent extends HomeEvent{}

// for getting category specified vendor
final class GetCategoryVendorReqeustEvent extends HomeEvent{
  final String categoryId;
  final String serchText;

 const GetCategoryVendorReqeustEvent({required this.categoryId , this.serchText = ''});
  
  @override
  List<Object> get props => [categoryId];
}



final class GetVendorProfileDetailsRequestEvent extends HomeEvent{
  final String categoryId;

const  GetVendorProfileDetailsRequestEvent({required this.categoryId});
  
  @override
  List<Object> get props => [categoryId];
}

// for geting best vendors 



