import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';

class InviteUserUseCase implements UseCase<int, Tuple2>{
  final EventsRepo repo;

  InviteUserUseCase(this.repo);

  @override
  Future<Either<Failure, int>> call(Tuple2 param) async{
    return await repo.inviteUserToEvent(param.value1, param.value2);
  }
}