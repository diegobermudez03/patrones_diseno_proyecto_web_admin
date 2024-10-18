import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/events/domain/use_cases/get_events_use_case.dart';
import 'package:web_admin/features/events/presentation/state/events_states.dart';
import 'package:web_admin/features/events/presentation/state/mappers.dart';

class EventsBloc extends Cubit<EventsState>{

  final GetEventsUseCase _getEventsUseCase;

  EventsBloc(
    this._getEventsUseCase
  ): super(EventsInitialState());

  void getEvents() async {
    await Future.delayed(Duration());
    emit(EventsRetrievingState());
   
    final response = await _getEventsUseCase(null);

    response.fold(
      (failure)=> emit(EventsRetrievingError()),
      (events){
        final state = EventsRetrievedState(
          events.map((entity)=> eventEntityToDTO(entity)).toList()
        );
        emit(state);
      });
  }

  void checkEvent(int eventId) async{
    
  }
  
}