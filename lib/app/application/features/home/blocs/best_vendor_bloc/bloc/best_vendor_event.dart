part of 'best_vendor_bloc.dart';

sealed class BestVendorEvent extends Equatable {
  const BestVendorEvent();

  @override
  List<Object> get props => [];
}

final class GetBestVendorRequestEvent extends BestVendorEvent{}