import 'package:get_it/get_it.dart';
import 'package:web_admin/features/events/domain/use_cases/get_events_use_case.dart';
import 'package:web_admin/features/events/presentation/state/events_bloc.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_state.dart';

final inst = GetIt.instance;


void initDependencies(){

  inst.registerFactory<InitialPageState>(()=> InitialPageState(0));

  //register events use cases
  inst.registerLazySingleton<GetEventsUseCase>(()=> GetEventsUseCase());

  //events bloc
  inst.registerFactory<EventsBloc>(()=> EventsBloc(
    inst.get<GetEventsUseCase>()
  ));

}