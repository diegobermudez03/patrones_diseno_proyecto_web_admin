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
          style: TextStyle(
            color: theme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        leading: const Icon(Icons.security), // Add a relevant icon
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
                    style: TextStyle(color: theme.error, fontSize: 16, fontStyle: FontStyle.italic),
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
                    style: TextStyle(color: theme.error, fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
            SessionsState _ => const Center(child: CircularProgressIndicator()),
          };

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Decorative Banner / Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.primary.withOpacity(0.8), theme.secondary.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadow.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.view_list,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.sessionsOverview,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Main Content - Split View of Sessions
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enabled Sessions
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: theme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.outlineVariant),
                          boxShadow: [
                            BoxShadow(
                              color: theme.shadow.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle, color: theme.primary, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  AppStrings.enabledSessions,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: theme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Expanded(
                              child: enabledSessions,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Disabled Sessions
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: theme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.outlineVariant),
                          boxShadow: [
                            BoxShadow(
                              color: theme.shadow.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.link_off, color: theme.error, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  AppStrings.disabledSessions,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: theme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Expanded(
                              child: disabledSessions,
                            ),
                          ],
                        ),
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
