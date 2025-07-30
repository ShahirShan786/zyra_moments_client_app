class TicketResponse {
  final Ticket ticket;
  final String qrCodeImage;

  TicketResponse({
    required this.ticket,
    required this.qrCodeImage,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
      ticket: Ticket.fromJson(json['ticket']),
      qrCodeImage: json['qrCodeImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticket': ticket.toJson(),
      'qrCodeImage': qrCodeImage,
    };
  }
}

class Ticket {
  final String ticketId;
  final String userId;
  final String eventId;
  final String paymentId;
  final String qrCode;
  final bool isScanned;
  final String status;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Ticket({
    required this.ticketId,
    required this.userId,
    required this.eventId,
    required this.paymentId,
    required this.qrCode,
    required this.isScanned,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketId: json['ticketId'],
      userId: json['userId'],
      eventId: json['eventId'],
      paymentId: json['paymentId'],
      qrCode: json['qrCode'],
      isScanned: json['isScanned'],
      status: json['status'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'userId': userId,
      'eventId': eventId,
      'paymentId': paymentId,
      'qrCode': qrCode,
      'isScanned': isScanned,
      'status': status,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
