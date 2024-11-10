import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/events/presentation/pages/event_page.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_dto.dart';
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
      backgroundColor: colorScheme.surfaceContainerHigh,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            Text(
              AppStrings.events,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar or Filter (Optional)
            _buildSearchBar(context, colorScheme),

            const SizedBox(height: 16),

            // Bloc Builder for State Management
            Expanded(
              child: BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  final provider = BlocProvider.of<EventsBloc>(context);

                  switch (state) {
                    case EventsRetrievingState _:
                      return Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.secondary,
                        ),
                      );

                    case EventsRetrievedState eventsState:
                      return _buildEventTable(eventsState.events, provider, context, colorScheme);

                    case EventsRetrievingError _:
                      return Center(
                        child: Text(
                          AppStrings.apiError,
                          style: TextStyle(
                            color: colorScheme.error,
                            fontSize: 16,
                          ),
                        ),
                      );

                    case EventsInitialState():
                      provider.getEvents();
                      return Container(); // Empty state
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, ColorScheme colorScheme) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: colorScheme.primary),
        hintText: 'Search events...',
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      onChanged: (query) {
        // Implement search or filter logic if needed
      },
    );
  }

  Widget _buildEventTable(
    List<EventDTO> events,
    EventsBloc provider,
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table Headers with Icons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.event, color: colorScheme.primary, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      AppStrings.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
             
             
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: colorScheme.primary, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      AppStrings.address,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 120), // Space for the action button
            ],
          ),
        ),
        const Divider(),

        // Table Content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: events
                  .map(
                    (event) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: EventTile(
                          event: event,
                          callback: () => _goToEvent(event.eventId, provider, context),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _goToEvent(int eventId, EventsBloc provider, BuildContext context) {
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
