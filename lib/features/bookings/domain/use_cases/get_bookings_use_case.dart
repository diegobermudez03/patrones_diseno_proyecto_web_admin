import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/bookings/domain/repositories/bookings_repo.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';

class GetBookingsUseCase implements UseCase<List<OccasionEntity>, void>{

  final BookingsRepo repo;

  GetBookingsUseCase(this.repo);

  @override
  Future<Either<Failure, List<OccasionEntity>>> call(void param) {
    return repo.getBookings();
  }
}