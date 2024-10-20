import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/events/presentation/pages/event_page.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_logs_bloc.dart';
import 'package:web_admin/features/events/presentation/state/events_bloc.dart';
import 'package:web_admin/features/events/presentation/state/events_states.dart';
import 'package:web_admin/features/events/presentation/widgets/event_tile.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: colorScheme.surfaceBright, // Use surfaceBright for the page background
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            const Text appTitle = Text(
              AppStrings.appTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
            final provider = BlocProvider.of<EventsBloc>(context);

            switch (state) {
              case EventsRetrievingState _:
                return Column(
                  children: [
                    appTitle,
                    const SizedBox(height: 20), // Space between title and loader
                    Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.secondary, // Use secondary color for loading
                      ),
                    ),
                  ],
                );
              case EventsRetrievedState eventsState:
                {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appTitle,
                      const SizedBox(height: 16),
                      // Table headers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              AppStrings.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface, // Header text color
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.startDate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface, // Header text color
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.endDate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface, // Header text color
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              AppStrings.address,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface, // Header text color
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Event tiles
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: eventsState.events
                                .map((event) => EventTile(
                                      event: event,
                                      callback: () => goToEvent(event.eventId, provider, context),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              case EventsRetrievingError _:
                return Center(
                  child: Text(
                    AppStrings.apiError,
                    style: TextStyle(
                      color: colorScheme.error, // Use error color for error messages
                    ),
                  ),
                );
              case EventsInitialState():
                {
                  provider.getEvents();
                  return Container(); // Empty state
                }
            }
          },
        ),
      ),
    );
  }

  void goToEvent(int eventId, EventsBloc provider, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetIt.instance.get<EventBloc>()),
          BlocProvider(create: (context) => GetIt.instance.get<EventLogsBloc>()),
        ],
        child: EventPage(eventId: eventId),
      ),
    ));
  }
}
