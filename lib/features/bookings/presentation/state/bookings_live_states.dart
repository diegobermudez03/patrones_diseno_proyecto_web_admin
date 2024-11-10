import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

abstract class BookingsLiveState{}

class BookingsLiveInitialState implements BookingsLiveState{}

class BookingLiveRetrieving implements BookingsLiveState{}

class BookingLiveRetrieved implements BookingsLiveState{
  final List<EventLogEntity> logs;

  BookingLiveRetrieved(this.logs);
}

class BookingLieveFailure implements BookingsLiveState{}

class BookingLiveNewLog implements BookingsLiveState{
  final List<EventLogEntity> logs;

  BookingLiveNewLog(this.logs);
}