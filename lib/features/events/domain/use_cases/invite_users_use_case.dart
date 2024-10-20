import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';

class InviteUsersUseCase implements UseCase<int, int>{
  @override
  Future<Either<Failure, int>> call(int eventId) async{
    await Future.delayed(Duration(seconds: 1));
    return Right(10);
  }
}