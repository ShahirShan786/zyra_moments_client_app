class HostEventModel {
  final bool success;
  final List<Event> events;
  final int totalPages;
  final int currentPage;

  HostEventModel({
    required this.success,
    required this.events,
    required this.totalPages,
    required this.currentPage,
  });

  factory HostEventModel.fromJson(Map<String, dynamic> json) {
    return HostEventModel(
      success: json['success'],
      events: List<Event>.from(json['events'].map((e) => Event.fromJson(e))),
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
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
  final String posterImage;
  final Coordinates coordinates;
  final Host host;
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
    required this.host,
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
      pricePerTicket: json['pricePerTicket'],
      ticketLimit: json['ticketLimit'],
      eventLocation: json['eventLocation'],
      posterImage: json['posterImage'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      host: Host.fromJson(json['hostId']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Coordinates {
  final String type;
  final List<double> coordinates;

  Coordinates({
    required this.type,
    required this.coordinates,
  });

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


// Host Event 

