import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';

class EventUsersList extends StatelessWidget{

  final List<EventUserDto> users;
  final int eventId;

  EventUsersList({
    super.key,
    required this.users,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(AppStrings.registered),
          TextButton(
            onPressed: ()=>inviteAll(context, eventId), 
            child: const Text(AppStrings.inviteRemaining)
          ),
          const Row(
            children: [
              Text(AppStrings.email),
              Text(AppStrings.name),
              Text(AppStrings.state),
              Text(AppStrings.currentState),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: users.map((user){
                return Container(
                  child: Row(children: [
                    Text(user.email), 
                    Text(user.phone),
                    Text(user.stateName),
                    if(user.stateName == AppStrings.registeredState)TextButton(
                      onPressed: ()=>inviteUser(context,user.occasionId, eventId ), 
                      child: Text(AppStrings.invite)
                    ),
                    Text('${user.isInside}')
                  ],),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  void inviteAll(BuildContext context, int eventId){
    BlocProvider.of<EventBloc>(context).inviteAll(eventId);
  }

  void inviteUser(BuildContext context, int occasionId, int eventId){
    BlocProvider.of<EventBloc>(context).inviteUsers(occasionId, eventId);
  }


}