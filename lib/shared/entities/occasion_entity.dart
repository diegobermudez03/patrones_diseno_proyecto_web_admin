import 'package:web_admin/features/bookings/domain/entities/booking_entity.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/shared/entities/state_entity.dart';
import 'package:web_admin/shared/entities/user_entity.dart';

class OccasionEntity{
  final int occasionId;
  final UserEntity user;
  final EventEntity? event;
  final BookingEntity? booking;
  final StateEntity state;
  final bool isInside;

  OccasionEntity(this.occasionId, this.user, this.event,this.booking, this.state, this.isInside);
}