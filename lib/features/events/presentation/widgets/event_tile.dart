import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
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
    final fieldWidth = (MediaQuery.of(context).size.width-300) / 5.5; // Divide screen into 5 equal parts

    return Card(
      color: colorScheme.surfaceContainer, // Use surfaceContainer for the tile background
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Spacing around the tile
      child: Padding(
        padding: const EdgeInsets.all(12), // Padding inside the tile
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Event Name
            SizedBox(
              width: fieldWidth,
              child: Text(
                event.eventName,
                style: TextStyle(
                  color: colorScheme.onSurface, // Text color
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Start Date
            SizedBox(
              width: fieldWidth,
              child: Text(
                event.startDate.toString(),
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant, // Subtle color for date
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // End Date
            SizedBox(
              width: fieldWidth,
              child: Text(
                event.endDate.toString(),
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Address
            SizedBox(
              width: fieldWidth,
              child: Text(
                event.address,
                style: TextStyle(
                  color: colorScheme.onTertiaryContainer, // Use tertiary color for the address
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Open Event Button
            SizedBox(
              width: fieldWidth,
              child: TextButton(
                onPressed: callback,
                style: TextButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer, // Use primary container for button background
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  AppStrings.openEvent,
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer, // Text color on the button
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
