import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/bookings/domain/repositories/bookings_repo.dart';

class InviteBookingUseCase implements UseCase<int, int>{

   final BookingsRepo repo;

  InviteBookingUseCase(this.repo);

  @override
  Future<Either<Failure, int>> call(int param) {
    return repo.inviteBooking(param);
  }
}