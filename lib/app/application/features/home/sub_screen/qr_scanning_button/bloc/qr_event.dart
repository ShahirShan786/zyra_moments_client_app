part of 'qr_bloc.dart';

abstract class QrEvent extends Equatable {
  const QrEvent();

  @override
  List<Object> get props => [];
}

class ScanQrCodeEvent extends QrEvent {}

class ResetQrScanEvent extends QrEvent {}

class SendQrcodeRequestEvent extends QrEvent{
  final String qrInfo;

 const SendQrcodeRequestEvent({required this.qrInfo});

  @override
  List<Object> get props => [qrInfo];
}