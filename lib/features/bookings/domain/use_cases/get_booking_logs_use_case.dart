import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

class GetBookingLogsUseCase implements UseCase<List<EventLogEntity>, void>{

  @override
  Future<Either<Failure, List<EventLogEntity>>> call(void param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}