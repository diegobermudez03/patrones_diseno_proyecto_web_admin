import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_states.dart';

class EventBloc extends Cubit<EventState> {
  EventBloc() : super(EventInitialState());

  void searchEvent(int eventId) async {
    await Future.delayed(Duration.zero);
    emit(SearchingEventState());
  }
}
