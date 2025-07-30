import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/app/data/repository/scan_qr_code_repository_impl.dart';
import 'package:zyra_momments_app/app/domain/repository/scan_qrcode_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';


class ScanQrCodeUsercases {
  ScanQrCodeRepository scanQrCodeRepository = ScanQrCodeRepositoryImpl();
  Future<String?> call()async{
 return await scanQrCodeRepository.getQrcodeScanData();
  }

  Future<Either<Failure,void>> sendQrcodeinfo(String qrInfo)async{
  return await scanQrCodeRepository.sendQrcodeinfo(qrInfo);
  }

  
}