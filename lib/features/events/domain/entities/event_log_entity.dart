class EventLogEntity{
  final int logId;
  final String email;
  final bool isInside;
  final DateTime time;

  EventLogEntity(this.logId, this.email, this.isInside, this.time);
}