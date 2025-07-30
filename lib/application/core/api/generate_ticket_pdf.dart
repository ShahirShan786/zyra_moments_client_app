import 'dart:convert';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateTicketPdf({
  required String eventName,
  required String ticketId,
  required String attendee,
  required String location,
  required String date,
  required String qrBase64, // base64 with or without header
}) async {
  final pdf = pw.Document();

  // Remove header if included
  final base64String = qrBase64.contains(',')
      ? qrBase64.split(',')[1]
      : qrBase64;

  // Convert base64 to Uint8List
  final qrImageBytes = base64Decode(base64String);
  final qrImage = pw.MemoryImage(qrImageBytes);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Padding(
          padding: pw.EdgeInsets.all(24),
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

              // QR Code
              pw.Center(
                child: pw.Image(qrImage, width: 180, height: 180),
              ),

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

  // Print or share the PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
