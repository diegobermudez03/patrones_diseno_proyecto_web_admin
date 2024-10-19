import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/events/domain/use_cases/get_event_users_use_case.dart';
import 'package:web_admin/features/events/presentation/state/event_states.dart';
import 'package:web_admin/features/events/presentation/state/mappers.dart';

class EventBloc extends Cubit<EventState> {

  final GetEventUsersUseCase _getEventUsersUseCase;

  EventBloc(
    this._getEventUsersUseCase,
  ) 
  : super(EventInitialState());

  void searchEvent(int eventId) async {
    await Future.delayed(Duration.zero);
    emit(SearchingEventState());
    final response = await _getEventUsersUseCase(eventId);
    response.fold(
      (f)=> emit(EventFailureState()), 
      (s)=> emit(
        EventUsersRetrievedState(s.map((ent)=> occasionToEventDTO(ent)).toList())
      )
    );
  }
}
