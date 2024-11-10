import 'package:web_admin/features/bookings/domain/repositories/bookings_repo.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

class BookingsConnectLiveLogsUseCase{
  final BookingsRepo repo;

  BookingsConnectLiveLogsUseCase(this.repo);

  Stream<EventLogEntity> call(){
    return repo.connectLogs();
  }
  
}