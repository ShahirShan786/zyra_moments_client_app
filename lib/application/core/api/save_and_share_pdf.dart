import 'dart:convert';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

Future<void> saveAndShareTicket({
  required String eventName,
  required String ticketId,
  required String attendee,
  required String location,
  required String date,
  required String qrBase64,
}) async {
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    print("❌ Permission denied");
    return;
  }

  final pdf = pw.Document();

  final base64String = qrBase64.contains(',')
      ? qrBase64.split(',')[1]
      : qrBase64;

  final qrImageBytes = base64Decode(base64String);
  final qrImage = pw.MemoryImage(qrImageBytes);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pw.Padding(
        padding: const pw.EdgeInsets.all(24),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child: pw.Text('EVENT TICKET', style: pw.TextStyle(fontSize: 24))),
            pw.SizedBox(height: 8),
            pw.Center(child: pw.Text(eventName, style: pw.TextStyle(fontSize: 18))),
            pw.Divider(),
            pw.SizedBox(height: 16),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Ticket ID: $ticketId'),
                    pw.Text('Attendee: $attendee'),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Date: $date'),
                    pw.Text('Location: $location'),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 24),
            pw.Center(child: pw.Image(qrImage, width: 180, height: 180)),
            pw.SizedBox(height: 12),
            pw.Center(child: pw.Text("Show this QR at entry.", style: pw.TextStyle(fontSize: 12))),
          ],
        ),
      ),
    ),
  );

  // Save to Downloads
  final downloadsDir = Directory('/storage/emulated/0/Download');
  final file = File('${downloadsDir.path}/Ticket-$ticketId.pdf');
  await file.writeAsBytes(await pdf.save());

  print("✅ File saved at: ${file.path}");

  // Share using share_plus
  await Share.shareXFiles(
    [XFile(file.path)],
    text: '🎟️ Here is your ticket for $eventName!',
  );
}
