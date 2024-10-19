import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/shared/entities/occasion_entity.dart';
import 'package:web_admin/shared/entities/state_entity.dart';
import 'package:web_admin/shared/entities/user_entity.dart';

class GetEventUsersUseCase implements UseCase<List<OccasionEntity>,int>{

  @override
  Future<Either<Failure, List<OccasionEntity>>> call(int param) async {
    await Future.delayed(const Duration(seconds: 1));
    final event = EventEntity(eventId: 1, eventName: "COMIC CON", address: "Calle 7a", startDate: DateTime.now(), endDate: DateTime.now());

    return Right(
      [
        OccasionEntity(
          1, 
          UserEntity(1, "d@bermu.com", "3008522427"), 
          event, 
          null, 
          StateEntity(1, "INVITADO"), 
          true
        ),
        OccasionEntity(
          2, 
          UserEntity(1, "dddd@bermu.com", "12345678"), 
          event, 
          null, 
          StateEntity(2, "REGISTRADO"), 
          true
        ),
        OccasionEntity(
          3, 
          UserEntity(1, "dsddfs@bermu.com", "85211223"), 
          event, 
          null, 
          StateEntity(3, "ACEPTADO"), 
          true
        ),
      ]
    );
  }

}