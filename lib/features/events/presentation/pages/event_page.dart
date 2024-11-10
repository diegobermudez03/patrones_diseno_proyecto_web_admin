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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surfaceContainerLowest, colorScheme.surfaceContainerLowest],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User List Panel (Left Side)
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
                              backgroundColor: colorScheme.surfaceContainer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              content: Text(
                                phrase,
                                style: TextStyle(color: colorScheme.onSurface),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(subContext).pop(),
                                  child: Text(
                                    AppStrings.ok,
                                    style: TextStyle(color: colorScheme.primary),
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
                            color: colorScheme.secondary,
                          ),
                        ),
                      EventUsersRetrievedState s => _buildSectionWithHeader(
                        context: context,
                        title: '${AppStrings.userList} - ${s.users.length} ${AppStrings.users}',
                        child: EventUsersList(users: s.users, eventId: eventId),
                        colorScheme: colorScheme,
                      ),
                      EventUsersInvitedState s => _buildSectionWithHeader(
                        context: context,
                        title: '${AppStrings.userList} - ${s.users.length} ${AppStrings.users}',
                        child: EventUsersList(users: s.users, eventId: eventId),
                        colorScheme: colorScheme,
                      ),
                      EventUserInvitedState s => _buildSectionWithHeader(
                        context: context,
                        title: '${AppStrings.userList} - ${s.users.length} ${AppStrings.users}',
                        child: EventUsersList(users: s.users, eventId: eventId),
                        colorScheme: colorScheme,
                      ),
                      EventFailureState _ => Center(
                          child: Text(
                            AppStrings.errorRetrievingUsers,
                            style: TextStyle(color: colorScheme.error),
                          ),
                        ),
                      EventState _ => Center(
                          child: CircularProgressIndicator(
                            color: colorScheme.secondary,
                          ),
                        ),
                    };
                  },
                ),
              ),
              const SizedBox(width: 16),

              // Logs Panel (Right Side)
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
                            color: colorScheme.secondary,
                          ),
                        ),
                      EventLogsRetrievedState s => _buildSectionWithHeader(
                        context: context,
                        title: AppStrings.liveLogs,
                        child: LogsPanel(logs: s.logs),
                        colorScheme: colorScheme,
                      ),
                      EventLogsNewLog s => _buildSectionWithHeader(
                        context: context,
                        title: AppStrings.liveLogs,
                        child: LogsPanel(logs: s.logs),
                        colorScheme: colorScheme,
                      ),
                      EventLogsState _ => Center(
                          child: CircularProgressIndicator(
                            color: colorScheme.secondary,
                          ),
                        ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Utility method to add a section with a header
  Widget _buildSectionWithHeader({
    required BuildContext context,
    required String title,
    required Widget child,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.label,
                color: colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
