// domain/entities/host_event.dart
class HostEventData {
  final String title;
  final String description;
  final String eventLocation;
  final String posterImage;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int pricePerTicket;
  final int ticketLimit;
  final List<double> coordinates;

  HostEventData({
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
}
