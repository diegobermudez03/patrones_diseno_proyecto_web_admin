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
        color: colorScheme.surface, // General surface color for the widget
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow, // Shadow color for depth
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.registered,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface, // Text color on surface
                ),
              ),
              ElevatedButton(
                onPressed: () => inviteAll(context, eventId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondary, // Button with secondary color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text(
                  AppStrings.inviteRemaining,
                  style: TextStyle(color: colorScheme.onSecondary), // OnSecondary for text
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Header Row for Field Titles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: fieldWidth,
                child: Text(
                  AppStrings.email,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant, // Use onSurfaceVariant for header text
                  ),
                ),
              ),
              Container(
                width: fieldWidth,
                child: Text(
                  AppStrings.phone,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Container(
                width: fieldWidth,
                child: Text(
                  AppStrings.state,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Container(
                width: fieldWidth,
                child: Text(
                  AppStrings.currentState,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Container(
                width: fieldWidth,
                child: Text(
                  AppStrings.action,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),

          // User Data Rows
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: users.map((user) =>
                  EventUserTile(
                    user: user,
                    callback: () => inviteUser(context, user.occasionId, eventId),
                  ),
                ).toList(),
              ),
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
