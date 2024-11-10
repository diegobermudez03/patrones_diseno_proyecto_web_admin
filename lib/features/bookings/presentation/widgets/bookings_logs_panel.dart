import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

class ReservationsLogsPanel extends StatelessWidget {
  final List<EventLogEntity> logs;

  const ReservationsLogsPanel({
    super.key,
    required this.logs,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ScrollController _scrollController = ScrollController();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.surfaceContainerLow, colorScheme.surfaceContainerLowest],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.4),
            blurRadius: 5,
            offset: const Offset(0, 4),
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
                Icons.history_edu,
                color: colorScheme.secondary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.logHistory,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Logs list as horizontal cards with left-click scrolling
          logs.isNotEmpty
              ? SizedBox(
                  height: 100,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      // Scrolls by delta of horizontal drag
                      _scrollController.jumpTo(
                        _scrollController.offset - details.delta.dx,
                      );
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: logs.length,
                      separatorBuilder: (context, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) =>
                          _buildLogCard(logs[index], colorScheme),
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
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

  Widget _buildLogCard(EventLogEntity log, ColorScheme colorScheme) {
    final String action = log.isInside ? AppStrings.entered : AppStrings.exited;
    final Color actionColor = log.isInside ? colorScheme.primary : colorScheme.error;

    // Conditionally set background color based on the action
    final Color backgroundColor = log.isInside
        ? Colors.green.withOpacity(0.1) // Slight green tint for "enter"
        : colorScheme.error.withOpacity(0.1);  // Slight red tint for "exit"

    return Container(
      width: 220,
      height: 50,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                log.isInside ? Icons.login : Icons.logout,
                color: actionColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                action,
                style: TextStyle(
                  color: actionColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
         // const SizedBox(height: 8),
          Text(
            log.email,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          //const Spacer(),
          Text(
            '${AppStrings.atTime} ${_formatDate(log.time)}',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
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
