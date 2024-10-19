import 'package:web_admin/features/events/presentation/state/dtos/event_dto.dart';

sealed class EventsState {}

class EventsInitialState extends EventsState {}

class EventsRetrievedState extends EventsState {
  final List<EventDTO> events;

  EventsRetrievedState(this.events);
}

class EventsRetrievingState extends EventsState {}

class EventsRetrievingError extends EventsState {}
