import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';
import 'package:web_admin/features/events/domain/use_cases/connect_live_logs_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/get_event_logs_use_case.dart';
import 'package:web_admin/features/events/presentation/state/event_logs_states.dart';

class EventLogsBloc extends Cubit<EventLogsState>{

  final GetEventLogsUseCase _getEventLogsUseCase;
  final ConnectLiveLogsUseCase _connectLiveLogsUseCase;

  EventLogsBloc(
    this._getEventLogsUseCase,
    this._connectLiveLogsUseCase
  ): super(EventLogsInitialState());

  void searchLogs(int eventId) async {
    await Future.delayed(Duration.zero);
    final response = await _getEventLogsUseCase(eventId);

    response.fold(
      (f)=> emit(EventLogsFailure()), 
      (logs)=> emit(EventLogsRetrievedState(logs.orderByDate())));
    connectLiveLogs(eventId);
  }
  
  void connectLiveLogs(int eventId) async{
    _connectLiveLogsUseCase(eventId).listen(
      (log){
        List<EventLogEntity> logs = [];
        if(state is EventLogsRetrievedState) logs = (state as EventLogsRetrievedState).logs;
        else if(state is EventLogsNewLog) logs = (state as EventLogsNewLog).logs;
        logs.add(log);
        emit(EventLogsNewLog(logs.orderByDate()));
      }
    );
  }

}

extension on List<EventLogEntity>{
  List<EventLogEntity> orderByDate(){
    for(int i = 0; i < this.length; i++){
      for(int j = i+1; j < this.length; j++){
        if(this[i].time.isBefore(this[j].time)){
          final aux = this[i];
          this[i] = this[j];
          this[j] = aux;
        }
      }
    }
    return this;
  }
}