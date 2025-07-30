import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

abstract class ScanQrCodeRepository {
  Future<String?> getQrcodeScanData();
  Future<Either<Failure,void>> sendQrcodeinfo(String qrInfo);
}