class EventResponse {
  final bool success;
  final List<Event> events;

  EventResponse({required this.success, required this.events});

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      success: json['success'],
      events: List<Event>.from(json['events'].map((e) => Event.fromJson(e))),
    );
  }
}

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final bool status;
  final String startTime;
  final String endTime;
  final int pricePerTicket;
  final int ticketLimit;
  final String eventLocation;
  final String? posterImage;
  final Coordinates coordinates;
  final Host hostId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.pricePerTicket,
    required this.ticketLimit,
    required this.eventLocation,
    required this.posterImage,
    required this.coordinates,
    required this.hostId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      // Convert to int safely - handles both int and double from JSON
      pricePerTicket: (json['pricePerTicket'] as num).toInt(),
      ticketLimit: (json['ticketLimit'] as num).toInt(),
      eventLocation: json['eventLocation'],
      posterImage: json['posterImage'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      hostId: Host.fromJson(json['hostId']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Coordinates {
  final String type;
  final List<double> coordinates;

  Coordinates({required this.type, required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates'].map((e) => e.toDouble())),
    );
  }
}

class Host {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  Host({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
