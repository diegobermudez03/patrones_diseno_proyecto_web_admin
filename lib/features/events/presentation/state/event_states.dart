import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';

abstract class EventState {}

class EventInitialState extends EventState {}

class SearchingEventState extends EventState {}

class EventFailureState extends EventState{}

class EventUsersRetrievedState extends EventState{
  final List<EventUserDto> users;

  EventUsersRetrievedState(this.users);
}


class EventUsersInvitedState extends EventState{
  final List<EventUserDto> users;
  final int nInvited;

  EventUsersInvitedState(this.users, this.nInvited);
}

class EventUserInvitedState extends EventState{
  final List<EventUserDto> users;
  final String email;

  EventUserInvitedState(this.users, this.email);
}