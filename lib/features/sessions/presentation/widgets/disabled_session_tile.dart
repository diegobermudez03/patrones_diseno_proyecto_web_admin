import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';

class DisabledSessionTile extends StatelessWidget {
  final SessionEntity session;
  final void Function(int, bool) callback;

  const DisabledSessionTile({
    super.key,
    required this.session,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.surfaceContainerLowest, theme.surfaceContainerLowest],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Prominent Icon on the left side
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: theme.errorContainer.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.link_off,
              color: theme.error,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),

          // Text content with formatted display
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.user.email,
                  style: TextStyle(
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.wantsToLinkWithA,
                  style: TextStyle(
                    color: theme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  session.phone_model,
                  style: TextStyle(
                    color: theme.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Enable button with a prominent style
          ElevatedButton.icon(
            onPressed: () => callback(session.id, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: theme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.check_circle, size: 20),
            label: Text(
              AppStrings.enable,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
