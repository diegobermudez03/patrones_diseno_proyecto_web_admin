import 'package:dartz/dartz.dart';
import 'package:web_admin/core/failures.dart';
import 'package:web_admin/core/use_case.dart';
import 'package:web_admin/features/events/domain/entities/event_entity.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';

class GetEventsUseCase implements UseCase<List<EventEntity>, void>{

  final EventsRepo repo;

  GetEventsUseCase(this.repo);

  @override
  Future<Either<Failure, List<EventEntity>>> call(_) async {
    return repo.getAllEvents();
  }

  
}