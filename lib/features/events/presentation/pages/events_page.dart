import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/events/presentation/pages/event_page.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';
import 'package:web_admin/features/events/presentation/state/events_bloc.dart';
import 'package:web_admin/features/events/presentation/state/events_states.dart';
import 'package:web_admin/features/events/presentation/widgets/event_tile.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          const Text appTitle = Text(AppStrings.appTitle);
          final provider = BlocProvider.of<EventsBloc>(context);
          switch (state) {
            case EventsRetrievingState _:
              return const Column(
                children: [
                  appTitle,
                  Center(child: CircularProgressIndicator())
                ],
              );
            case EventsRetrievedState eventsState:
              {
                return Column(
                  children: [
                    appTitle,
                    const Row(
                      children: [
                        Text(AppStrings.name),
                        Text(AppStrings.startDate),
                        Text(AppStrings.endDate),
                        Text(AppStrings.address),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: eventsState.events
                            .map((event) => EventTile(
                                  event: event,
                                  callback: () => goToEvent(
                                      event.eventId, provider, context),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                );
              }
            case EventsRetrievingError _:
              return const Center(
                child: Text(AppStrings.apiError),
              );
            case EventsInitialState():
              {
                provider.getEvents();
                return Container();
              }
          }
        },
      ),
    );
  }

  void goToEvent(int eventId, EventsBloc provider, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (conxt) => BlocProvider(
              create: (context) => GetIt.instance.get<EventBloc>(),
              child: EventPage(
                eventId: eventId,
              ),
            )));
  }
}
