import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';

class GetEventsUseCase implements UseCase<List<EventEntity>, void>{
  @override
  Future<Either<Failure, List<EventEntity>>> call(_) async {
    await Future.delayed(Duration(seconds: 0));

    return Right([
      EventEntity(eventId: 1, eventName: 'comic con', address: 'corferias', startDate: DateTime.now(), endDate: DateTime.now()),
      EventEntity(eventId: 2, eventName: 'Javeexpo', address: 'javeriana', startDate: DateTime.now(), endDate: DateTime.now()),
    ]);
  }

  
}