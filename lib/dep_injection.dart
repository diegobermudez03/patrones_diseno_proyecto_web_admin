import 'package:get_it/get_it.dart';
import 'package:web_admin/features/bookings/data/repositories/bookings_repo_impl.dart';
import 'package:web_admin/features/bookings/domain/repositories/bookings_repo.dart';
import 'package:web_admin/features/bookings/domain/use_cases/connect_live_logs_use_case.dart';
import 'package:web_admin/features/bookings/domain/use_cases/get_booking_logs_use_case.dart';
import 'package:web_admin/features/bookings/domain/use_cases/get_bookings_use_case.dart';
import 'package:web_admin/features/bookings/domain/use_cases/invite_booking_use_case.dart';
import 'package:web_admin/features/bookings/presentation/state/booking_live_bloc.dart';
import 'package:web_admin/features/bookings/presentation/state/bookings_bloc.dart';
import 'package:web_admin/features/events/data/repositories/events_repo_impl.dart';
import 'package:web_admin/features/events/domain/repositories/events_repo.dart';
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
import 'package:web_admin/features/sessions/data/repositories/sessions_repo_impl.dart';
import 'package:web_admin/features/sessions/domain/repositories/sessions_repo.dart';
import 'package:web_admin/features/sessions/domain/use_cases/change_session_use_case.dart';
import 'package:web_admin/features/sessions/domain/use_cases/get_sessions_use_case.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_bloc.dart';

final inst = GetIt.instance;
const uri = "http://localhost:3000";

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
  //REPOS
  inst.registerLazySingleton<EventsRepo>(()=> EventsRepoImpl(uri));

  //register events use cases
  inst.registerLazySingleton<GetEventsUseCase>(() => GetEventsUseCase(
    inst.get<EventsRepo>()
  ));
  inst.registerLazySingleton<GetEventUsersUseCase>(()=> GetEventUsersUseCase(
    inst.get<EventsRepo>()
  ));
  inst.registerLazySingleton<GetEventLogsUseCase>(() => GetEventLogsUseCase(
    inst.get<EventsRepo>()
  ));
  inst.registerLazySingleton<ConnectLiveLogsUseCase>(() => ConnectLiveLogsUseCase(
    inst.get<EventsRepo>()
  ));
  inst.registerLazySingleton<InviteUsersUseCase>(()=> InviteUsersUseCase(
    inst.get<EventsRepo>()
  ));
  inst.registerLazySingleton<InviteUserUseCase>(()=> InviteUserUseCase(
    inst.get<EventsRepo>()
  ));

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


  // BOOKING DEPENDENCIES
  //repo
  inst.registerLazySingleton<BookingsRepo>(()=>BookingsRepoImpl(uri));

  //use cases
  inst.registerLazySingleton<InviteBookingUseCase>(()=>InviteBookingUseCase(
    inst.get()
  ));

  inst.registerLazySingleton<GetBookingsUseCase>(()=>GetBookingsUseCase(
    inst.get()
  ));

  inst.registerLazySingleton<BookingsConnectLiveLogsUseCase>(()=>BookingsConnectLiveLogsUseCase(
    inst.get()
  ));

  inst.registerLazySingleton<GetBookingLogsUseCase>(()=>GetBookingLogsUseCase(
    inst.get()
  ));


  //bloc
  //bookings bloc
  inst.registerFactory<BookingsBloc>(()=>BookingsBloc(
    inst.get(), 
    inst.get()
  ));

   inst.registerFactory<BookingLiveBloc>(()=>BookingLiveBloc(
    inst.get(), 
    inst.get()
  ));



  //INJECTING SESSIONS DEPENDENCIES
  //sessions repo
  inst.registerLazySingleton<SessionsRepo>(()=> SessionsRepoImpl(uri));

  //sessions use cases
  inst.registerLazySingleton<GetSessionsUseCase>(()=> GetSessionsUseCase(
    inst.get<SessionsRepo>()
  ));
  inst.registerLazySingleton<ChangeSessionUseCase>(()=> ChangeSessionUseCase(
    inst.get<SessionsRepo>()
  ));

  //sessions bloc
  inst.registerFactory<SessionsBloc>(()=> SessionsBloc(
    inst.get<GetSessionsUseCase>(),
    inst.get<ChangeSessionUseCase>(),
  ));

}
