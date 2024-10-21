import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';

abstract class EventsRepo{
  Future<Either<Failure, List<EventEntity>>> getAllEvents();
}