import 'package:web_admin/features/events/data/events_parsers.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';

SessionEntity jsonToSessionEntity(Map<String, dynamic> json){
  return SessionEntity(
    json["session_id"], 
    jsonToUserEntity(json["user"]), 
    json["enabled"], 
    json["phone_model"]
  );
}