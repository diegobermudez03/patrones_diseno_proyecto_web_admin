import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';
import 'package:web_admin/features/sessions/presentation/widgets/enabled_session_tile.dart';

class EnabledSessionsWidget extends StatelessWidget {
  final List<SessionEntity> sessions;
  final void Function(int, bool) callback;

  const EnabledSessionsWidget({
    super.key,
    required this.sessions,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: theme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with Icon
          Row(
            children: [
              Icon(
                Icons.verified_user,
                color: theme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.activeSessions,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Header Row with Enhanced Styling
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: theme.primaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHeaderCell(theme, AppStrings.email),
                _buildHeaderCell(theme, AppStrings.phone),
                _buildHeaderCell(theme, AppStrings.model),
                _buildHeaderCell(theme, AppStrings.action),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Scrollable List of EnabledSessionTile
          Expanded(
            child: sessions.isNotEmpty
                ? ListView.separated(
                    itemCount: sessions.length,
                    separatorBuilder: (_, __) => Divider(
                      color: theme.outline.withOpacity(0.2),
                      thickness: 0.5,
                    ),
                    itemBuilder: (context, index) {
                      return EnabledSessionTile(
                        session: sessions[index],
                        callback: callback,
                      );
                    },
                  )
                : Center(
                    child: Text(
                      AppStrings.noActiveSessions,
                      style: TextStyle(
                        color: theme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Helper method to build header cells with consistent styling
  Widget _buildHeaderCell(ColorScheme theme, String label) {
    return Expanded(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: theme.onSurfaceVariant,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
