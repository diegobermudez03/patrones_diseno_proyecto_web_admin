import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';

class InviteUserUseCase implements UseCase<String, int>{
  @override
  Future<Either<Failure, String>> call(int param) async{
    await Future.delayed(Duration(seconds: 1));
    return Right("jj@gmail.com");
  }
}