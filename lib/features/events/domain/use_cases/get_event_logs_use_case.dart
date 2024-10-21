import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';

class GetEventLogsUseCase implements UseCase<List<EventLogEntity>, int>{

  final EventsRepo repo;

  GetEventLogsUseCase(this.repo);

  @override
  Future<Either<Failure, List<EventLogEntity>>> call(int param) async{
    return await repo.getAllLogs(param);
  }
}