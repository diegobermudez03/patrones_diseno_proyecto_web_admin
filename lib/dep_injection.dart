import 'package:get_it/get_it.dart';
import 'package:web_admin/features/events/domain/use_cases/connect_live_logs_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/get_event_logs_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/get_event_users_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/get_events_use_case.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_logs_bloc.dart';
import 'package:web_admin/features/events/presentation/state/events_bloc.dart';
import 'package:web_admin/features/initial_page/domain/use_cases/upload_excel_use_case.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_bloc.dart';

final inst = GetIt.instance;

void initDependencies() {
  //INJECTIN INITAL PAGE DEPENDENCIES

  //  USE CASES
  inst.registerLazySingleton<UploadExcelUseCase>(() => UploadExcelUseCase());

  //BLOC
  inst.registerFactory<InitialPageBloc>(
      () => InitialPageBloc(inst.get<UploadExcelUseCase>()));

  //INJECTING EVENTS DEPENDENCIES
  //register events use cases
  inst.registerLazySingleton<GetEventsUseCase>(() => GetEventsUseCase());
  inst.registerLazySingleton<GetEventUsersUseCase>(()=> GetEventUsersUseCase());
  inst.registerLazySingleton<GetEventLogsUseCase>(() => GetEventLogsUseCase());
  inst.registerLazySingleton<ConnectLiveLogsUseCase>(() => ConnectLiveLogsUseCase());

  //events bloc
  inst.registerFactory<EventsBloc>(() => EventsBloc(
    inst.get<GetEventsUseCase>()
  ));
  inst.registerFactory<EventBloc>(() => EventBloc(
    inst.get<GetEventUsersUseCase>()
  ));
  inst.registerFactory<EventLogsBloc>(()=> EventLogsBloc(
    inst.get<GetEventLogsUseCase>(), 
    inst.get<ConnectLiveLogsUseCase>(), 
  ));
}
