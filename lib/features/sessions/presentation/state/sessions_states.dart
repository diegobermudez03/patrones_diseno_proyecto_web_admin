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

class SessionsChangingState implements SessionsState{
  final List<SessionEntity> enabledSessions;
  final List<SessionEntity> disabledSessions;
  final int changingId;

  SessionsChangingState(this.enabledSessions, this.disabledSessions, this.changingId);
}

class SessionsChangingFailure implements SessionsState{
  final List<SessionEntity> enabledSessions;
  final List<SessionEntity> disabledSessions;

  SessionsChangingFailure(this.enabledSessions, this.disabledSessions);

}