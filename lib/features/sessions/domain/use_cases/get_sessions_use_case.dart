import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';
import 'package:web_admin/features/sessions/domain/repositories/sessions_repo.dart';

class GetSessionsUseCase implements UseCase<Tuple2<List<SessionEntity>, List<SessionEntity>>, void>{

  final SessionsRepo repo;

  GetSessionsUseCase(this.repo);

  @override
  Future<Either<Failure, Tuple2<List<SessionEntity>, List<SessionEntity>>>> call(void param) async{
    final result = await repo.getSessions();
    return result.fold(
      (f)=> Left(f), 
      (sessions)=>Right(
        Tuple2(
          sessions.where((session)=> session.enabled).toList(),
          sessions.where((session)=> !session.enabled).toList()
        )
      )
    );
  }

}