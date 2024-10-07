import 'package:flutter/material.dart';
import 'package:web_admin/features/events/presentation/state/dtos/eventDTO.dart';

class EventTile extends StatelessWidget{

  final EventDTO event;

  EventTile(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row( 
        children: [
          Text(event.eventName),
          Text(event.startDate.toString()),
          Text(event.endDate.toString()),
          Text(event.address)
        ],
      ),
    );
  }
}