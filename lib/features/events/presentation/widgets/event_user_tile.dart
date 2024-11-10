import 'package:flutter/material.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';

class EventUserTile extends StatelessWidget {
  final EventUserDto user;
  final void Function() callback;

  const EventUserTile({
    super.key,
    required this.user,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerWidth = MediaQuery.of(context).size.width * 0.6;

    return SizedBox(
      width: containerWidth,
      child: Card(
        color: colorScheme.surfaceContainerHighest,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: colorScheme.shadow.withOpacity(0.15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User icon with initials or avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  _getUserInitials(user.email),
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // User Details
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: colorScheme.secondary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          user.phone,
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // User State
              Expanded(
                flex: 1,
                child: _buildStateBadge(user.stateName, colorScheme),
              ),

              // User Presence Status
              Expanded(
                flex: 1,
                child: _buildPresenceIndicator(user.isInside, colorScheme),
              ),

              // Action Button (if applicable)
              Expanded(
                flex: 1,
                child: _buildAction(user.stateName, colorScheme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStateBadge(String state, ColorScheme colorScheme) {
    Color badgeColor;
    String badgeText;

    if (state == AppStrings.registeredState) {
      badgeColor = colorScheme.secondary;
      badgeText = AppStrings.userRegistered;
    } else if (state == AppStrings.invitedState) {
      badgeColor = colorScheme.tertiary;
      badgeText = AppStrings.invited;
    } else {
      badgeColor = colorScheme.primary;
      badgeText = AppStrings.confirmed;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          badgeText,
          style: TextStyle(
            color: badgeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPresenceIndicator(bool isInside, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isInside ? Icons.check_circle : Icons.cancel,
          color: isInside ? colorScheme.primary : colorScheme.error,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          isInside ? AppStrings.inside : AppStrings.outside,
          style: TextStyle(
            fontSize: 14,
            color: isInside ? colorScheme.primary : colorScheme.error,
          ),
        ),
      ],
    );
  }

  Widget _buildAction(String state, ColorScheme colorScheme) {
    if (state == AppStrings.registeredState) {
      return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor: colorScheme.tertiaryFixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          AppStrings.invite,
          style: TextStyle(
            color: colorScheme.onTertiaryFixed,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink(); // No action if not registered state
    }
  }

  String _getUserInitials(String email) {
    return email.isNotEmpty ? email[0].toUpperCase() : '?';
  }
}
