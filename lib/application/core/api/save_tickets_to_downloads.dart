import 'dart:convert';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'dart:developer';

Future<void> saveTicketToDownloads({
  required String eventName,
  required String ticketId,
  required String attendee,
  required String location,
  required String date,
  required String qrBase64,
}) async {
  // 1. Request storage permission
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    log("❌ Storage permission denied");
    return;
  }

  // 2. Decode the QR base64 image
  final base64String = qrBase64.contains(',')
      ? qrBase64.split(',')[1]
      : qrBase64;
  final qrImageBytes = base64Decode(base64String);
  final qrImage = pw.MemoryImage(qrImageBytes);

  // 3. Create the PDF document
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text('EVENT TICKET',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 8),
              pw.Center(
                child: pw.Text(eventName,
                    style: pw.TextStyle(fontSize: 18, color: PdfColors.grey800)),
              ),
              pw.Divider(),
              pw.SizedBox(height: 16),

              // Ticket + Event details
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Ticket Details
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('TICKET DETAILS',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Ticket ID: $ticketId'),
                      pw.Text('Attendee: $attendee'),
                    ],
                  ),

                  // Event Details
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('EVENT DETAILS',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Date: $date'),
                      pw.Text('Location: $location'),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 24),
              pw.Center(child: pw.Image(qrImage, width: 180, height: 180)),
              pw.SizedBox(height: 16),
              pw.Center(
                child: pw.Text(
                  'Please present this QR code at the event entrance for admission.',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // 4. Save the file to Downloads
  final downloadsDir = Directory('/storage/emulated/0/Download');
  final file = File('${downloadsDir.path}/Ticket-$ticketId.pdf');

  await file.writeAsBytes(await pdf.save());

  print("✅ PDF saved to: ${file.path}");

  // 5. Open file automatically
  await OpenFile.open(file.path);
}
