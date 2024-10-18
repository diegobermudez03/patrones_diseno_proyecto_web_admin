import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_states.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class EventPage extends StatelessWidget {
  final int eventId;
  const EventPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
        final provider = BlocProvider.of<EventBloc>(context);
        switch (state) {
          case EventInitialState _:
            provider.searchEvent(eventId);
            break;
          case SearchingEventState _:
            return const CircularProgressIndicator();
        }
        return Container();
      }),
    );
  }
}
