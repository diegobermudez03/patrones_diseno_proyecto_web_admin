import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_dto.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

EventDTO eventEntityToDTO( EventEntity entity){
  return EventDTO(
    eventId: entity.eventId, 
    eventName: entity.eventName, 
    address: entity.address, 
    startDate: entity.startDate, 
    endDate: entity.endDate
  );
}

EventUserDto occasionToEventDTO(OccasionEntity entity){
  return EventUserDto(
    entity.occasionId, 
    entity.user.email, 
    entity.user.number, 
    entity.state.stateName,
    entity.isInside
  );
}