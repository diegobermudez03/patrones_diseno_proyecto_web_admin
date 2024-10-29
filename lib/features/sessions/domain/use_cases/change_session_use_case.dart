import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/sessions/domain/repositories/sessions_repo.dart';

class ChangeSessionUseCase implements UseCase<bool, Tuple2<int, bool>>{

  final SessionsRepo repo;

  ChangeSessionUseCase(this.repo);

  @override
  Future<Either<Failure, bool>> call(Tuple2<int, bool> param)async {
    return repo.actionSession(param);
  }
}