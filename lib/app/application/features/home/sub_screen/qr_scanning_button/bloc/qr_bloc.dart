import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:zyra_momments_app/app/domain/usecases/scan_qr_code_usercases.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  final ScanQrCodeUsercases scanQrCodeUsercases;

  QrBloc({required this.scanQrCodeUsercases}) : super(QrInitial()) {
    on<ScanQrCodeEvent>(_onScanQrCode);
    on<ResetQrScanEvent>(_onResetQrScan);
    on<SendQrcodeRequestEvent>(_onSentQrcodeInfo);
  }

  Future<void> _onScanQrCode(
    ScanQrCodeEvent event,
    Emitter<QrState> emit,
  ) async {
    try {
      emit(QrScanningState());

      final result = await scanQrCodeUsercases.call();

      if (result != null && result.isNotEmpty) {
        emit(QrScanSuccessState(result));
      } else {
        emit(const QrScanErrorState('No QR code found or unable to scan'));
      }
    } catch (e) {
      emit(QrScanErrorState('Failed to scan QR code: ${e.toString()}'));
    }
  }

  void _onResetQrScan(
    ResetQrScanEvent event,
    Emitter<QrState> emit,
  ) {
    emit(QrInitial());
  }

  void _onSentQrcodeInfo(
      SendQrcodeRequestEvent event, Emitter<QrState> emit) async {
    emit(ScanQrIfoLoadingState());

    final result = await scanQrCodeUsercases.sendQrcodeinfo(event.qrInfo);

    result.fold((failure) {
      emit(ScanQrInfoFailureState(errorMessage: failure.message));
    }, (success) {
      emit(ScanQrInfoSuccessState());
    });
  }
}
