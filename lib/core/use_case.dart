import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';

abstract class UseCase<T, R>{
  Future<Either<Failure, T>> call(R param);
}