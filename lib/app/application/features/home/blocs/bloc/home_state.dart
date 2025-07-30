part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

// get categoroies

final class CategoryLoadingState extends HomeState {}

final class GetCategorySuccessState extends HomeState {
  final List<Categories> categories;

  const GetCategorySuccessState({required this.categories});

  @override
  List<Object> get props => [categories];
}

final class GetCategoryFailureState extends HomeState {
  final String errorMessage;

  const GetCategoryFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// for getting category specified vendor

final class GetCategoryVendorSuccessState extends HomeState {
  final List<Vendor> vendorList;

  const GetCategoryVendorSuccessState({required this.vendorList});
  @override
  List<Object> get props => [vendorList];
}

final class GetCategoryVendorFailureState extends HomeState {
  final String errorMessage;

  const GetCategoryVendorFailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

// get vendor profile details

final class GetvendorProfileSuccessState extends HomeState {
  final VendorProfileModel vendorDetails;

  const GetvendorProfileSuccessState({required this.vendorDetails});

  @override
  List<Object> get props => [vendorDetails];
}

final class GetVendorProfileFaiureState extends HomeState {
  final String errorMessage;

  const GetVendorProfileFaiureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}


class NoVendorsFoundState  extends HomeState{}

