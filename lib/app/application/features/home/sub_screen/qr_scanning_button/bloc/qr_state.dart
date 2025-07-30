part of 'qr_bloc.dart';


abstract class QrState extends Equatable {
  const QrState();
  
  @override
  List<Object?> get props => [];
}

class QrInitial extends QrState {}

class QrScanningState extends QrState {}

class QrScanSuccessState extends QrState {
  final String qrData;
  
  const QrScanSuccessState(this.qrData);
  
  @override
  List<Object> get props => [qrData];
}

class QrScanErrorState extends QrState {
  final String message;
  
  const QrScanErrorState(this.message);
  
  @override
  List<Object> get props => [message];
}

// For sending Qr code information

class ScanQrIfoLoadingState extends QrState{}

class ScanQrInfoSuccessState extends QrState{}

class ScanQrInfoFailureState extends QrState{
  final String errorMessage;

 const ScanQrInfoFailureState({required this.errorMessage});
}