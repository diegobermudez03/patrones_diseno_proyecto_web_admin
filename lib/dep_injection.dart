import 'package:get_it/get_it.dart';
import 'package:web_admin/features/events/domain/use_cases/connect_live_logs_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/get_event_logs_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/get_event_users_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/get_events_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/invite_user_use_case.dart';
import 'package:web_admin/features/events/domain/use_cases/invite_users_use_case.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_logs_bloc.dart';
import 'package:web_admin/features/events/presentation/state/events_bloc.dart';
import 'package:web_admin/features/initial_page/data/repositories/excel_repo_impl.dart';
import 'package:web_admin/features/initial_page/domain/repositories/excel_repo.dart';
import 'package:web_admin/features/initial_page/domain/use_cases/upload_excel_use_case.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_bloc.dart';

final inst = GetIt.instance;
const uri = "localhost:3000";

void initDependencies() {
  //INJECTIN INITAL PAGE DEPENDENCIES

  //REPOS
  inst.registerLazySingleton<ExcelRepo>(()=> ExcelRepoImpl(uri));

  //  USE CASES
  inst.registerLazySingleton<UploadExcelUseCase>(() => UploadExcelUseCase(
    inst.get<ExcelRepo>()
  ));

  //BLOC
  inst.registerFactory<InitialPageBloc>(
      () => InitialPageBloc(inst.get<UploadExcelUseCase>()));

  //INJECTING EVENTS DEPENDENCIES
  //register events use cases
  inst.registerLazySingleton<GetEventsUseCase>(() => GetEventsUseCase());
  inst.registerLazySingleton<GetEventUsersUseCase>(()=> GetEventUsersUseCase());
  inst.registerLazySingleton<GetEventLogsUseCase>(() => GetEventLogsUseCase());
  inst.registerLazySingleton<ConnectLiveLogsUseCase>(() => ConnectLiveLogsUseCase());
  inst.registerLazySingleton<InviteUsersUseCase>(()=> InviteUsersUseCase());
  inst.registerLazySingleton<InviteUserUseCase>(()=> InviteUserUseCase());

  //events bloc
  inst.registerFactory<EventsBloc>(() => EventsBloc(
    inst.get<GetEventsUseCase>()
  ));
  inst.registerFactory<EventBloc>(() => EventBloc(
    inst.get<GetEventUsersUseCase>(),
    inst.get<InviteUsersUseCase>(),
    inst.get<InviteUserUseCase>(),
  ));
  inst.registerFactory<EventLogsBloc>(()=> EventLogsBloc(
    inst.get<GetEventLogsUseCase>(), 
    inst.get<ConnectLiveLogsUseCase>(), 
  ));
}
