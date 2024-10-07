class EventDTO{
  final int eventId;
  final String eventName;
  final String address;
  final DateTime startDate;
  final DateTime endDate;

  EventDTO({
    required this.eventId,
    required this.eventName,
    required this.address,
    required this.startDate,
    required this.endDate
  });
}