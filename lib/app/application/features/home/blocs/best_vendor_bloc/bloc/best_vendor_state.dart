part of 'best_vendor_bloc.dart';

sealed class BestVendorState extends Equatable {
  const BestVendorState();
  
  @override
  List<Object> get props => [];
}

final class BestVendorInitial extends BestVendorState {}

// for getting best venodors

final class GetBestvendorLoadingState extends BestVendorState{}

final class GetBestVenodorSuccessState extends BestVendorState{
  final List<Vendor> bestVendors;

 const GetBestVenodorSuccessState({required this.bestVendors});
   @override
  List<Object> get props => [bestVendors];

}

final class GetBestvendorFailureState extends BestVendorState{
  final String errorMessage;

const  GetBestvendorFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}