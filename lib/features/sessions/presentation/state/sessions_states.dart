import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';

abstract class SessionsState{}

class SessionsInitalState implements SessionsState{}

class SessionsRetrievingState implements SessionsState{}

class SessionsRetrievingFailure implements SessionsState{}

class SessionsRetrievedState implements SessionsState{
  final List<SessionEntity> enabledSessions;
  final List<SessionEntity> disabledSessions;

  SessionsRetrievedState(this.enabledSessions, this.disabledSessions);
}