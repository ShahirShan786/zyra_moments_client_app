import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_tools/qr_code_tools.dart';

import 'package:file_picker/file_picker.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:zyra_momments_app/app/data/datasource/qrcode_remote_data_source.dart';
import 'dart:ui' as ui;

import 'package:zyra_momments_app/app/domain/repository/scan_qrcode_repository.dart';
import 'package:zyra_momments_app/core/error/failure.dart';

class ScanQrCodeRepositoryImpl implements ScanQrCodeRepository {
  final QrcodeRemoteDataSource qrcodeRemoteDataSource = QrcodeRemoteDataSourceImpl();
  @override
  Future<String?> getQrcodeScanData() async {
    try {
      final picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
        allowMultiple: false,
      );

      if (picked == null || picked.files.isEmpty) return null;

      final platformFile = picked.files.single;
      final path = platformFile.path;

      if (path == null) return null;

      final file = File(path);

      if (!await file.exists()) return null;

      if (path.toLowerCase().endsWith('.pdf')) {
        return await _extractQrFromPdf(file);
      } else {
        return await _decodeQrFromImage(file);
      }
    } catch (e) {
      print('Error in ScanQrCodeRepositoryImpl: $e');
      return null;
    }
  }

Future<String?> _extractQrFromPdf(File pdfFile) async {
  PdfDocument? doc;
  try {
    doc = await PdfDocument.openFile(pdfFile.path);
    final page = doc.pages[0];

    // Render the PDF page to an image
    final pageImage = await page.render(
      width: page.width.toInt(),
      height: page.height.toInt(),
    );

    if (pageImage == null) {
      print('Failed to render PDF page to image.');
      return null;
    }

    // Create a Dart UI image from the PdfImage
    final uiImage = await pageImage.createImage();
    final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData == null) {
      print('Failed to convert image to byte data.');
      return null;
    }

    final pngBytes = byteData.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempImagePath = '${tempDir.path}/pdf_page_${DateTime.now().millisecondsSinceEpoch}.png';
    final tempImageFile = File(tempImagePath);
    await tempImageFile.writeAsBytes(pngBytes);

    final qrResult = await _decodeQrFromImage(tempImageFile);

    if (await tempImageFile.exists()) {
      await tempImageFile.delete();
    }

    return qrResult;
  } catch (e) {
    print('Error extracting QR from PDF: $e');
    return null;
  } finally {
    await doc?.dispose();
  }
}

  Future<String?> _decodeQrFromImage(File imageFile) async {
    try {
      final result = await QrCodeToolsPlugin.decodeFrom(imageFile.path);
      return result;
    } catch (e) {
      print('Error decoding QR from image: $e');
      return null;
    }
  }

  @override
  Future<Either<Failure, void>> sendQrcodeinfo(String qrInfo) async{
   return await qrcodeRemoteDataSource.sendQrcodeinfo(qrInfo);
  }
}
