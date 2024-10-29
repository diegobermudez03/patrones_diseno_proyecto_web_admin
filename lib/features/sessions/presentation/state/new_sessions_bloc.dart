import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/sessions/presentation/state/new_sessions_states.dart';

class NewSessionsBloc extends Cubit<NewSessionsState>{

  NewSessionsBloc(

  ): super(NewSessionsInitalState());

}