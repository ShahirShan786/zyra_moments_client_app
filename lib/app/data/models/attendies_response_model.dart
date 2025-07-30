class AttendanceResponse {
  final bool success;
  final EventData? data;
  final String? message;

  AttendanceResponse({
    required this.success,
    required this.data,
    this.message,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? EventData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }
}

class EventData {
  final String eventId;
  final String title;
  final DateTime date;
  final List<Attendance> attendance;
  final int totalTickets;
  final int scannedTickets;

  EventData({
    required this.eventId,
    required this.title,
    required this.date,
    required this.attendance,
    required this.totalTickets,
    required this.scannedTickets,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      eventId: json['eventId'] ?? '',
      title: json['title'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      attendance: (json['attendance'] as List<dynamic>?)
              ?.map((x) => Attendance.fromJson(x))
              .toList() ??
          [],
      totalTickets: json['totalTickets'] ?? 0,
      scannedTickets: json['scannedTickets'] ?? 0,
    );
  }
}

class Attendance {
  final String ticketId;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final bool isScanned;
  final DateTime? scannedAt;
  final String status;

  Attendance({
    required this.ticketId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isScanned,
    required this.scannedAt,
    required this.status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      ticketId: json['ticketId'] ?? '',
      userId: json['userId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      isScanned: json['isScanned'] ?? false,
      scannedAt: json['scannedAt'] != null
          ? DateTime.tryParse(json['scannedAt'])
          : null,
      status: json['status'] ?? '',
    );
  }
}
