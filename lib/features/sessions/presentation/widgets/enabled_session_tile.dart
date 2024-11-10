import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';

class EnabledSessionTile extends StatelessWidget {
  final SessionEntity session;
  final void Function(int, bool) callback;

  const EnabledSessionTile({
    super.key,
    required this.session,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Space between tiles
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: theme.outlineVariant, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon / Image for the session (Profile Icon Placeholder)
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: theme.primaryContainer.withOpacity(0.5),
              child: Icon(
                Icons.smartphone, // Represents the device (change icon if needed)
                color: theme.onPrimaryContainer,
              ),
            ),
          ),
          // User Information Columns
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.user.email,
                  style: TextStyle(
                    color: theme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  session.user.number,
                  style: TextStyle(
                    color: theme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Phone Model Column
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.phone_model,
                  style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Status Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppStrings.activeSession,
                    style: TextStyle(
                      color: theme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Disable Button
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () => callback(session.id, false),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.error,
                foregroundColor: theme.onError,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.block, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    AppStrings.disable,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
