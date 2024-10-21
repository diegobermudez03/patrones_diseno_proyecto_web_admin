import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

class GetEventUsersUseCase implements UseCase<List<OccasionEntity>,int>{

  final EventsRepo repo;

  GetEventUsersUseCase(this.repo);

  @override
  Future<Either<Failure, List<OccasionEntity>>> call(int param) async {
    return await repo.getOccasionsFromEvent(param);
  }

}