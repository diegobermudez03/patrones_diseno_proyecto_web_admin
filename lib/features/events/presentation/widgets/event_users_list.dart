import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/dtos/event_user_dto.dart';

class EventUsersList extends StatelessWidget{

  final List<EventUserDto> users;

  EventUsersList({
    super.key,
    required this.users
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(AppStrings.registered),
          TextButton(
            onPressed: (){}, 
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
                    if(user.stateName == AppStrings.registeredState)TextButton(onPressed: (){}, child: Text(AppStrings.invite)),
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


}