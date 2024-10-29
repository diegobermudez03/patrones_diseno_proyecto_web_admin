import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';
import 'package:web_admin/features/sessions/presentation/widgets/disabled_session_tile.dart';

class DisabledSessionsWidget extends StatelessWidget {
  final List<SessionEntity> sessions;
  final void Function(int, bool) callback;

  DisabledSessionsWidget({
    super.key,
    required this.sessions,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Center(
            child: Text(
              AppStrings.requests,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Scrollable List of DisabledSessionTile
          SingleChildScrollView(
            child: Column(
              children: sessions
                  .map((s) => DisabledSessionTile(
                        session: s,
                        callback: callback,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
