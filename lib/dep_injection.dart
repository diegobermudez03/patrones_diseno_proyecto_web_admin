import 'package:get_it/get_it.dart';
import 'package:web_admin/features/events/presentation/state/events_state.dart';
import 'package:web_admin/features/initial_page/presentation/state/initial_page_state.dart';

final inst = GetIt.instance;


void initDependencies(){

  inst.registerFactory<InitialPageState>(()=> InitialPageState(0));
  inst.registerFactory<EventsState>(()=> EventsState(0));

}