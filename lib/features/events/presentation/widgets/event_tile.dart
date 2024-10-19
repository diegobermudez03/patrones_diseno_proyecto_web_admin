import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_dto.dart';

class EventTile extends StatelessWidget{

  final EventDTO event;
  final void Function() callback;

  const EventTile({
    super.key,
    required this.event, 
    required this.callback
});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row( 
        children: [
          Text(event.eventName),
          Text(event.startDate.toString()),
          Text(event.endDate.toString()),
          Text(event.address),
          TextButton(
            onPressed: callback, 
            child: const Text(AppStrings.openEvent)
          )
        ],
      ),
    );
  }
}