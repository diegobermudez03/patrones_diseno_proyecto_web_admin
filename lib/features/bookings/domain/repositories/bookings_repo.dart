import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

abstract class BookingsRepo{
  Future<Either<Failure, List<OccasionEntity>>> getBookings();
  Future<Either<Failure, int>> inviteBooking (int id);
  Future<Either<Failure, List<EventLogEntity>>> getAllLogs();
  Stream<EventLogEntity> connectLogs();
}