import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';

abstract class EventState {}

class EventInitialState extends EventState {}

class SearchingEventState extends EventState {}

class EventFailureState extends EventState{}

class EventUsersRetrievedState extends EventState{
  final List<EventUserDto> users;

  EventUsersRetrievedState(this.users);
}
