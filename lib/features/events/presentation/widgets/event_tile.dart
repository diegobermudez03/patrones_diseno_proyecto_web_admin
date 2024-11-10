import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_dto.dart';

class EventTile extends StatelessWidget {
  final EventDTO event;
  final void Function() callback;

  const EventTile({
    super.key,
    required this.event,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.surface,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Event Icon with Background Circle
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer.withOpacity(0.2),
              ),
              child: Icon(
                Icons.event,
                color: colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),

            // Event Details Column
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: colorScheme.primary.withOpacity(0.7),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_formatDate(event.startDate)} - ${_formatDate(event.endDate)}',
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Address Section
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.address,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Divider
            Container(
              height: 48,
              width: 1,
              color: colorScheme.outlineVariant.withOpacity(0.3),
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),

            // Open Event Button with Icon
            TextButton.icon(
              onPressed: callback,
              style: TextButton.styleFrom(
                backgroundColor: colorScheme.secondaryContainer,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                Icons.open_in_new,
                color: colorScheme.onSecondaryContainer,
                size: 20,
              ),
              label: Text(
                AppStrings.openEvent,
                style: TextStyle(
                  color: colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to format dates (assuming DateTime type)
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}'; // Customize as needed
  }
}
