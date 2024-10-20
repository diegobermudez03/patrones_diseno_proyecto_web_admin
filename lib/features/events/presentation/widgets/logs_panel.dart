import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
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
      padding: const EdgeInsets.all(16.0), // Padding around the panel
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow, // Use surfaceContainerLow for the background
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow, // Consistent use of shadow color
            blurRadius: 8,
            offset: const Offset(0, 2), // Light shadow for depth
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel title
          Text(
            AppStrings.logHistory,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface, // Use onSurface color for title
            ),
          ),
          const SizedBox(height: 16), // Space between title and logs

          // Logs list
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: logs.map((log) {
                  final String action = log.isInside ? AppStrings.entered : AppStrings.exited;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12), // Margin between log entries
                    padding: const EdgeInsets.all(12), // Padding inside each log entry
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer, // Slightly different surface color for log entries
                      borderRadius: BorderRadius.circular(8), // Rounded corners for log entry
                      border: Border.all(color: colorScheme.outlineVariant), // Border using outlineVariant color
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurface, // Text color for logs
                        ),
                        children: [
                          TextSpan(
                            text: log.email,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary, // Primary color for email text
                            ),
                          ),
                          TextSpan(text: ' $action '),
                          TextSpan(
                            text: AppStrings.atTime,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: colorScheme.tertiary, // Tertiary color for italic text
                            ),
                          ),
                          TextSpan(
                            text: ' ${log.time}',
                            style: TextStyle(color: colorScheme.onSurfaceVariant), // Subtle contrast for time
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
