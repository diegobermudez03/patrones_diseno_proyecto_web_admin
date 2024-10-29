import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';

abstract class SessionsRepo{
  Future<Either<Failure, List<SessionEntity>>> getSessions();

}