import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';
import 'package:web_admin/features/sessions/domain/use_cases/change_session_use_case.dart';
import 'package:web_admin/features/sessions/domain/use_cases/get_sessions_use_case.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_states.dart';

class SessionsBloc extends Cubit<SessionsState>{

  final GetSessionsUseCase _getSessionsUseCase;
  final ChangeSessionUseCase _changeSessionUseCase;

  SessionsBloc(
    this._getSessionsUseCase,
    this._changeSessionUseCase
  ): super(SessionsInitalState());

  void getSessions() async{
    await Future.delayed(Duration.zero);
    emit(SessionsRetrievingState());

    final response = await this._getSessionsUseCase(null);

    response.fold(
      (f)=> emit(SessionsRetrievingFailure()), 
      (result)=> emit(SessionsRetrievedState(result.value1, result.value2))
    );
  }

  void changeSession(int id, bool enable) async{
    await Future.delayed(Duration.zero);
    final List<SessionEntity> enabled = switch(state){
      SessionsRetrievedState(enabledSessions : final en) => en,
      SessionsChangingState(enabledSessions: final en) => en,
      SessionsChangingFailure(enabledSessions: final en) => en,
      SessionsState _ => []
    };
    final List<SessionEntity> disabled = switch(state){
      SessionsRetrievedState(disabledSessions : final dis) => dis,
      SessionsChangingState(disabledSessions: final dis) => dis,
      SessionsChangingFailure(disabledSessions: final dis) => dis,
      SessionsState _ => []
    };
    emit(SessionsChangingState(enabled, disabled, id));
    final response = await _changeSessionUseCase(Tuple2<int, bool>(id, enable));

    response.fold(
      (f)=> emit(SessionsChangingFailure(enabled, disabled)), 
      (s){
        if(enable){
          final session = disabled.where((s)=>s.id == id).first;
          session.enabled = true;
          disabled.remove(session);
          enabled.add(session);
        }else{
          final session = enabled.where((s)=>s.id == id).first;
          session.enabled = false;
          enabled.remove(session);
          disabled.add(session);
        }
        emit(SessionsRetrievedState(enabled, disabled));
      });

  }

}