import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

abstract class EventsRepo{
  Future<Either<Failure, List<EventEntity>>> getAllEvents();
  Future<Either<Failure, List<OccasionEntity>>> getOccasionsFromEvent(int eventId);
  Future<Either<Failure, List<EventLogEntity>>> getAllLogs(int eventId);
  Stream<EventLogEntity> connectLogs(int eventId);
}