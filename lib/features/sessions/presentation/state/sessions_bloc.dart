import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/sessions/domain/use_cases/get_sessions_use_case.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_states.dart';

class SessionsBloc extends Cubit<SessionsState>{

  final GetSessionsUseCase _getSessionsUseCase;

  SessionsBloc(
    this._getSessionsUseCase
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

}