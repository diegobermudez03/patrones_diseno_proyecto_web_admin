import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';

class EventUserTile extends StatelessWidget {
  final EventUserDto user;
  final void Function() callback;

  EventUserTile({
    super.key,
    required this.user,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerWidth = MediaQuery.of(context).size.width * 0.4;
    final fieldWidth = containerWidth / 5.5;
    final bool isRegistered = user.stateName == AppStrings.registeredState;

    return SizedBox(
      width: containerWidth,
      child: Card(
        color: colorScheme.surfaceContainerHighest, // Highest surface container for the card background
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        elevation: 4, // Increased elevation for more prominence
        shadowColor: colorScheme.shadow, // Consistent shadow color
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: fieldWidth,
                child: Text(
                  user.email,
                  style: TextStyle(
                    color: colorScheme.onSurface, // Use onPrimaryFixedDim for text color
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: fieldWidth,
                child: Text(
                  user.phone,
                  style: TextStyle(
                    color: colorScheme.onPrimaryFixed, // Use onPrimaryFixedVariant for text color
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: fieldWidth,
                child: Text(
                  user.stateName.isEmpty ? '' : user.stateName,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant, // Use onTertiaryContainer for state name
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: fieldWidth,
                child: Text(
                  '${user.isInside}',
                  style: TextStyle(
                    color: colorScheme.secondaryFixedDim, // Use secondaryFixedDim for boolean state display
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              isRegistered
                  ? SizedBox(
                      width: fieldWidth,
                      child: ActionButton(callback: callback, colorScheme: colorScheme),
                    )
                  : SizedBox(width: fieldWidth),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final void Function() callback;
  final ColorScheme colorScheme;

  ActionButton({required this.callback, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: colorScheme.tertiaryFixed, // Use tertiaryFixed for the button background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        AppStrings.invite,
        style: TextStyle(
          color: colorScheme.onTertiaryFixed, // Use onTertiaryFixed for the button text color
        ),
      ),
    );
  }
}
