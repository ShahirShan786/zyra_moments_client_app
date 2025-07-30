class HostEvent {
  final String title;
  final String description;
  final String eventLocation;
  final String posterImage;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int pricePerTicket;
  final int ticketLimit;
  final Coordinates coordinates;

  HostEvent({
    required this.title,
    required this.description,
    required this.eventLocation,
    required this.posterImage,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.pricePerTicket,
    required this.ticketLimit,
    required this.coordinates,
  });

  factory HostEvent.fromJson(Map<String, dynamic> json) {
    return HostEvent(
      title: json['title'],
      description: json['description'],
      eventLocation: json['eventLocation'],
      posterImage: json['posterImage'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      pricePerTicket: json['pricePerTicket'],
      ticketLimit: json['ticketLimit'],
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'eventLocation': eventLocation,
      'posterImage': posterImage,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'pricePerTicket': pricePerTicket,
      'ticketLimit': ticketLimit,
      'coordinates': coordinates.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
