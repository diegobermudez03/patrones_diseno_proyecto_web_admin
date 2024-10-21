import 'package:web_admin/features/bookings/data/parsers.dart';
import 'package:web_admin/features/events/data/events_parsers.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';
import 'package:web_admin/shared/entities/state_entity.dart';

OccasionEntity jsonToOccasionEntity(Map<String, dynamic> json){
  return OccasionEntity(
    json["occasion_id"], 
    jsonToUserEntity(json["user"]), 
    json["event"] != null ? jsonToEventEntity(json["event"]) : null,
    json["booking"] != null ? jsonToBookingEntity(json["booking"]) : null,
    jsonToStateEntity(json["state"]), 
    json["inside"]
  );
}

StateEntity jsonToStateEntity(Map<String, dynamic> json){
  return StateEntity(
    json["state_id"], 
    json["state_name"]
  );
}