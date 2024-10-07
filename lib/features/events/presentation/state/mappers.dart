import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/features/events/presentation/state/dtos/eventDTO.dart';

EventDTO eventEntityToDTO( EventEntity entity){
  return EventDTO(
    eventId: entity.eventId, 
    eventName: entity.eventName, 
    address: entity.address, 
    startDate: entity.startDate, 
    endDate: entity.endDate
  );
}