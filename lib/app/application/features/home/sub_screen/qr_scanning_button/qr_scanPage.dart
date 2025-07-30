import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/qr_scanning_button/bloc/qr_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/qr_scanning_button/widgets/show_verification_dialoques.dart';
import 'package:zyra_momments_app/app/application/features/home/sub_screen/qr_scanning_button/widgets/show_verification_failed_dailoque.dart';

class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'QR Scanner',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: BlocListener<QrBloc, QrState>(
        listener: (context, state) {
          if (state is QrScanSuccessState) {
            context
                .read<QrBloc>()
                .add(SendQrcodeRequestEvent(qrInfo: state.qrData));
            // _showSuccessDialog(context, state.qrData);
          } else if (state is QrScanErrorState) {
            _showErrorSnackBar(context, state.message);
            log("error message : ${state.message}");
          } else if (state is ScanQrInfoSuccessState) {
            showVerificationDialog(context);
          } else if (state is ScanQrInfoFailureState) {
          showVerificationFailedDialog(context , message: state.errorMessage);
            log("error message : ${state.errorMessage}");
          }
        },
        child: BlocBuilder<QrBloc, QrState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // QR Scanner Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      size: 60,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Title
                  const Text(
                    'Scan QR Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'Upload an image or PDF file containing a QR code to scan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Scan Button or Loader
                  if (state is QrScanningState ||
                      state is ScanQrIfoLoadingState)
                    const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  else
                    ElevatedButton(
                      onPressed: () {
                        context.read<QrBloc>().add(ScanQrCodeEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.upload_file),
                          SizedBox(width: 8),
                          Text(
                            'Select File to Scan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Supported formats
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[800]!,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Supported Formats',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildFormatChip('PDF'),
                            _buildFormatChip('PNG'),
                            _buildFormatChip('JPG'),
                            _buildFormatChip('JPEG'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                      onPressed: () => showVerificationFailedDialog(context,
                          message:
                              "This QR code has already been scanned. Entry is not allowed."),
                      icon: Icon(Icons.access_alarm))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Format Chip Builder
  Widget _buildFormatChip(String format) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        format,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Error SnackBar
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

}
