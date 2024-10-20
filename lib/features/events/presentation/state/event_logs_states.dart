import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

abstract class EventLogsState{}

class EventLogsInitialState implements EventLogsState{}

class EventLogsRetrieving implements EventLogsState{}

class EventLogsFailure implements EventLogsState{}

class EventLogsRetrievedState implements EventLogsState{
  final List<EventLogEntity> logs;

  EventLogsRetrievedState(this.logs);
}

class EventLogsNewLog implements EventLogsState{
  final List<EventLogEntity> logs;

  EventLogsNewLog(this.logs);
}
