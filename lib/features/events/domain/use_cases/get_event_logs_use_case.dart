import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

class GetEventLogsUseCase implements UseCase<List<EventLogEntity>, int>{
  @override
  Future<Either<Failure, List<EventLogEntity>>> call(int param) async{
    await Future.delayed(const Duration(seconds: 1));
    return Right([
      EventLogEntity(1, "Juan@ddd", true, DateTime.now()),
      EventLogEntity(2, "asd@ddd", false, DateTime.now()),
      EventLogEntity(3, "eeee@ddd", false, DateTime.now()),
      EventLogEntity(4, "aaaaa@ddd", true, DateTime.now()),
    ]);
  }
}