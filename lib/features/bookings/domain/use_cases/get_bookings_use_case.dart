import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

class GetBookingsUseCase implements UseCase<List<OccasionEntity>, void>{
  @override
  Future<Either<Failure, List<OccasionEntity>>> call(void param) {
    // TODO: implement call
    throw UnimplementedError();
  }
}