import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';

class InviteUsersUseCase implements UseCase<int, int>{

  final EventsRepo repo;

  InviteUsersUseCase(this.repo);
  
  @override
  Future<Either<Failure, int>> call(int eventId) async{
    return await repo.inviteAllUsers(eventId);
  }
}