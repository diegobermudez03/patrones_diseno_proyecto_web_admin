import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

class LogsPanel extends StatelessWidget {
  final List<EventLogEntity> logs;

  const LogsPanel({
    super.key,
    required this.logs,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.surfaceContainerLow, colorScheme.surfaceContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel title with icon
          Row(
            children: [
              Icon(
                Icons.history,
                color: colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.logHistory,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Logs list
          Expanded(
            child: logs.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: logs.map((log) {
                        final String action = log.isInside ? AppStrings.entered : AppStrings.exited;
                        final IconData actionIcon = log.isInside ? Icons.login : Icons.logout;
                        final Color actionColor = log.isInside ? colorScheme.primary : colorScheme.error;

                        return _buildLogEntry(log, action, actionIcon, actionColor, colorScheme);
                      }).toList(),
                    ),
                  )
                : Center(
                    child: Text(
                      AppStrings.noLogs,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogEntry(EventLogEntity log, String action, IconData actionIcon, Color actionColor, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Action Icon with Circular Background
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: actionColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              actionIcon,
              color: actionColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Log Details
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface,
                ),
                children: [
                  TextSpan(
                    text: log.email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  TextSpan(text: ' $action '),
                  TextSpan(
                    text: AppStrings.atTime,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  TextSpan(
                    text: ' ${_formatDate(log.time)}',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}'; // Customize as needed
  }
}
