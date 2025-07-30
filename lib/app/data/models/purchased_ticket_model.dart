class PurchasedTicketModel {
  final bool success;
  final List<Ticket> tickets;
  final int totalPages;
  final int currentPage;

  PurchasedTicketModel({
    required this.success,
    required this.tickets,
    required this.totalPages,
    required this.currentPage,
  });

  factory PurchasedTicketModel.fromJson(Map<String, dynamic> json) {
    return PurchasedTicketModel(
      success: json['success'],
      tickets:
          List<Ticket>.from(json['tickets'].map((x) => Ticket.fromJson(x))),
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'tickets': tickets.map((x) => x.toJson()).toList(),
      'totalPages': totalPages,
      'currentPage': currentPage,
    };
  }
}

class Ticket {
  final String id;
  final String ticketId;
  final String userId;
  final Event eventId;
  final String paymentId;
  final String qrCode;
  final bool isScanned;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? scannedAt;

  Ticket({
    required this.id,
    required this.ticketId,
    required this.userId,
    required this.eventId,
    required this.paymentId,
    required this.qrCode,
    required this.isScanned,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.scannedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'],
      ticketId: json['ticketId'],
      userId: json['userId'],
      eventId: Event.fromJson(json['eventId']),
      paymentId: json['paymentId'],
      qrCode: json['qrCode'],
      isScanned: json['isScanned'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      scannedAt:
          json['scannedAt'] != null ? DateTime.parse(json['scannedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'ticketId': ticketId,
      'userId': userId,
      'eventId': eventId.toJson(),
      'paymentId': paymentId,
      'qrCode': qrCode,
      'isScanned': isScanned,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (scannedAt != null) 'scannedAt': scannedAt!.toIso8601String(),
    };
  }
}

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String startTime;
  final String endTime;
  final num pricePerTicket;
  final num ticketLimit;
  final String eventLocation;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.pricePerTicket,
    required this.ticketLimit,
    required this.eventLocation,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      pricePerTicket: (json['pricePerTicket'] as num).toInt(),
      ticketLimit: (json['ticketLimit'] as num).toInt(),
      eventLocation: json['eventLocation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'pricePerTicket': pricePerTicket,
      'ticketLimit': ticketLimit,
      'eventLocation': eventLocation,
    };
  }
}
