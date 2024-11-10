import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';
import 'package:web_admin/features/events/presentation/widgets/event_user_tile.dart';

class EventUsersList extends StatelessWidget {
  final List<EventUserDto> users;
  final int eventId;

  EventUsersList({
    super.key,
    required this.users,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final fieldWidth = (screenWidth * 0.4) / 5.5;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.surface, colorScheme.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Invite Button Row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title with Icon
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.registered,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),

                // Invite All Button
                ElevatedButton.icon(
                  onPressed: () => inviteAll(context, eventId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  icon: Icon(Icons.send, color: colorScheme.onSecondary, size: 20),
                  label: Text(
                    AppStrings.inviteRemaining,
                    style: TextStyle(color: colorScheme.onSecondary),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Header Row with Icons and Text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                _buildHeaderCell(AppStrings.email, Icons.email, fieldWidth, colorScheme),
                _buildHeaderCell(AppStrings.phone, Icons.phone, fieldWidth, colorScheme),
                _buildHeaderCell(AppStrings.state, Icons.flag, fieldWidth, colorScheme),
                _buildHeaderCell(AppStrings.currentState, Icons.location_on, fieldWidth, colorScheme),
                _buildHeaderCell(AppStrings.action, Icons.settings, fieldWidth, colorScheme),
              ],
            ),
          ),
          const Divider(),

          // User Tiles
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: users
                    .map(
                      (user) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: EventUserTile(
                          user: user,
                          callback: () => inviteUser(context, user.occasionId, eventId),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String label, IconData icon, double width, ColorScheme colorScheme) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void inviteAll(BuildContext context, int eventId) {
    BlocProvider.of<EventBloc>(context).inviteAll(eventId);
  }

  void inviteUser(BuildContext context, int occasionId, int eventId) {
    BlocProvider.of<EventBloc>(context).inviteUsers(occasionId, eventId);
  }
}
