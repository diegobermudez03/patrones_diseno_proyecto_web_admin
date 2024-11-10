import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_bloc.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_states.dart';
import 'package:web_admin/features/sessions/presentation/widgets/enabled_sessions_widget.dart';
import 'package:web_admin/features/sessions/presentation/widgets/disabled_sessions_widget.dart';

class SessionsPage extends StatelessWidget {
  SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: theme.primary,
        title: Text(
          AppStrings.sessions,
          style: TextStyle(color: theme.onPrimary),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SessionsBloc, SessionsState>(builder: (context, state) {
          final provider = BlocProvider.of<SessionsBloc>(context);

          if (state is SessionsInitalState) {
            provider.getSessions();
          }

          final Widget enabledSessions = switch (state) {
            SessionsRetrievedState(enabledSessions: final en) =>
                EnabledSessionsWidget(sessions: en, callback: actionOnSession(provider)),
            SessionsRetrievingFailure() => Center(
                  child: Text(
                    AppStrings.apiError,
                    style: TextStyle(color: theme.error),
                  ),
                ),
            SessionsState _ => const Center(child: CircularProgressIndicator()),
          };

          final Widget disabledSessions = switch (state) {
            SessionsRetrievedState(disabledSessions: final dis) =>
                DisabledSessionsWidget(sessions: dis, callback: actionOnSession(provider)),
            SessionsRetrievingFailure() => Center(
                  child: Text(
                    AppStrings.apiError,
                    style: TextStyle(color: theme.error),
                  ),
                ),
            SessionsState _ => const Center(child: CircularProgressIndicator()),
          };

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dashboard Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppStrings.sessions,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Dashboard Content
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enabled Sessions Widget
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: enabledSessions,
                      ),
                    ),
                    // Disabled Sessions Widget
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: disabledSessions,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void Function(int, bool) actionOnSession(SessionsBloc provider) {
    return (id, enable) => provider.changeSession(id, enable);
  }
}
