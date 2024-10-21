import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';

class ConnectLiveLogsUseCase{

  final EventsRepo repo;

  ConnectLiveLogsUseCase(this.repo);

  Stream<EventLogEntity> call(int eventId){
    return repo.connectLogs(eventId);
  }
}