import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/bookings/domain/use_cases/connect_live_logs_use_case.dart';
import 'package:web_admin/features/bookings/domain/use_cases/get_booking_logs_use_case.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_live_states.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

class BookingLiveBloc extends Cubit<BookingsLiveState>{

  final GetBookingLogsUseCase _bookingLogsUseCase;
  final BookingsConnectLiveLogsUseCase _connectLiveLogsUseCase;

  BookingLiveBloc(
    this._bookingLogsUseCase,
    this._connectLiveLogsUseCase
  ): super(BookingsLiveInitialState());

   void searchLogs() async {
    await Future.delayed(Duration.zero);
    final response = await _bookingLogsUseCase(null);

    response.fold(
      (f)=> emit(BookingLieveFailure()), 
      (logs)=> emit(BookingLiveRetrieved(logs.orderByDate())));
    connectLiveLogs();
  }

    void connectLiveLogs() async{
    _connectLiveLogsUseCase().listen(
      (log){
        List<EventLogEntity> logs = [];
        if(state is BookingLiveRetrieved) logs = (state as BookingLiveRetrieved).logs;
        else if(state is BookingLiveNewLog) logs = (state as BookingLiveNewLog).logs;
        logs.add(log);
        emit(BookingLiveNewLog(logs.orderByDate()));
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