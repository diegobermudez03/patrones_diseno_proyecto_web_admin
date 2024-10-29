import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
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
    final String sentence = '${session.user.email} ${AppStrings.wantsToLinkWithA} ${session.phone_model}';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
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
      child: Row(
        children: [
          // Icon on the left side
          Icon(
            Icons.link_off,
            color: theme.onSurfaceVariant,
            size: 32,
          ),
          const SizedBox(width: 12),
          
          // Text content
          Expanded(
            child: Text(
              sentence,
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 16,
              ),
            ),
          ),
          
          // Enable button
          TextButton(
            onPressed: () => callback(session.id, true),
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              AppStrings.enable,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
