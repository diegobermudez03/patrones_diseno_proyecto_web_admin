import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_logs_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_logs_states.dart';
import 'package:web_admin/features/events/presentation/state/event_states.dart';
import 'package:web_admin/features/events/presentation/widgets/event_users_list.dart';
import 'package:web_admin/features/events/presentation/widgets/logs_panel.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class EventPage extends StatelessWidget {
  final int eventId;
  const EventPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: colorScheme.surfaceBright, // Use surfaceBright as the main background color
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding for the screen's content
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Left side: User list (table)
            Expanded(
              flex: 3,
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  final provider = BlocProvider.of<EventBloc>(context);

                  if (state is EventInitialState) {
                    provider.searchEvent(eventId);
                  }

                  if (state is EventUsersInvitedState || state is EventUserInvitedState) {
                    String phrase = switch (state) {
                      EventUsersInvitedState s => '${s.nInvited} ${AppStrings.nUsersInvited}',
                      EventUserInvitedState s => '${s.email} ${AppStrings.hasBeenInvited}',
                      EventState() => '',
                    };

                    Future.microtask(() {
                      showDialog(
                        context: context,
                        builder: (subContext) {
                          return AlertDialog(
                            backgroundColor: colorScheme.surfaceContainer, // Dialog background
                            content: Text(
                              phrase,
                              style: TextStyle(color: colorScheme.onSurface), // Dialog text color
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(subContext).pop();
                                },
                                child: Text(
                                  AppStrings.ok,
                                  style: TextStyle(color: colorScheme.primary), // Button text color
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  }

                  return switch (state) {
                    SearchingEventState _ => Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.secondary, // Use secondary color for the loading indicator
                        ),
                      ),
                    EventUsersRetrievedState s => EventUsersList(users: s.users, eventId: eventId),
                    EventUsersInvitedState s => EventUsersList(users: s.users, eventId: eventId),
                    EventUserInvitedState s => EventUsersList(users: s.users, eventId: eventId),
                    EventFailureState _ => Center(
                        child: Text(
                          AppStrings.errorRetrievingUsers,
                          style: TextStyle(color: colorScheme.error), // Error text color
                        ),
                      ),
                    EventState _ => Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.secondary, // Use secondary color for the loading indicator
                        ),
                      ),
                  };
                },
              ),
            ),
            const SizedBox(width: 10,),
            // Right side: Logs panel
            Expanded(
              flex: 2,
              child: BlocBuilder<EventLogsBloc, EventLogsState>(
                builder: (context, state) {
                  final provider = BlocProvider.of<EventLogsBloc>(context);

                  if (state is EventLogsInitialState) {
                    provider.searchLogs(eventId);
                  }

                  return switch (state) {
                    EventLogsRetrieving _ => Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.secondary, // Use secondary color for loading indicator
                        ),
                      ),
                    EventLogsRetrievedState s => LogsPanel(logs: s.logs),
                    EventLogsNewLog s => LogsPanel(logs: s.logs),
                    EventLogsState _ => Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.secondary, // Use secondary color for loading indicator
                        ),
                      ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
