import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

class ConnectLiveLogsUseCase{
  Stream<EventLogEntity> call(int eventId)async*{
    while(true){
      await Future.delayed(Duration(seconds: 1));
      yield EventLogEntity(1, "jjsjs@gmail.com", true, DateTime.now());
    }
  }
}