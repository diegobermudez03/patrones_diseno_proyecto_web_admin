import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';
import 'package:web_admin/shared/entities/user_entity.dart';

EventEntity jsonToEventEntity(Map<String, dynamic> json){
  return EventEntity(
    eventId: json["event_id"], 
    eventName: json["name"], 
    address: json["address"], 
    startDate: DateTime.parse(json["start_date"]), 
    endDate: DateTime.parse(json["end_date"])
  );
}


UserEntity jsonToUserEntity(Map<String, dynamic> json){
  return UserEntity(
    json["user_id"], 
    json["email"],
    json["number"] 
  );
}

EventLogEntity jsonToEventLogEntity(Map<String, dynamic> json){
  return EventLogEntity(
    json["log_id"], 
    json["email"], 
    json["is_inside"], 
    DateTime.parse(json["time"])
  );
}

