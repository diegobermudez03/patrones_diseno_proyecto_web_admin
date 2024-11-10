import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';
import 'package:web_admin/features/sessions/presentation/widgets/disabled_session_tile.dart';

class DisabledSessionsWidget extends StatelessWidget {
  final List<SessionEntity> sessions;
  final void Function(int, bool) callback;

  const DisabledSessionsWidget({
    super.key,
    required this.sessions,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.surfaceContainer, theme.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Centered Title with Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.request_page,
                color: theme.primary,
                size: 26,
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.requests,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Scrollable List of DisabledSessionTile
          Expanded(
            child: sessions.isNotEmpty
                ? ListView.builder(
                    itemCount: sessions.length,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DisabledSessionTile(
                          session: sessions[index],
                          callback: callback,
                        ),
                      );
                    },
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        AppStrings.noRequests,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
