import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Email Column
          Expanded(
            flex: 2,
            child: Text(
              session.user.email,
              style: TextStyle(color: theme.onSurface, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          // Number Column
          Expanded(
            flex: 1,
            child: Text(
              session.user.number,
              style: TextStyle(color: theme.onSurface, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          // Phone Model Column
          Expanded(
            flex: 2,
            child: Text(
              session.phone_model,
              style: TextStyle(color: theme.onSurface, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          // Disable Button
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => callback(session.id, false),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text(
                AppStrings.disable,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
