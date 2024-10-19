import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/events/presentation/state/event_bloc.dart';
import 'package:web_admin/features/events/presentation/state/event_states.dart';
import 'package:web_admin/features/events/presentation/widgets/event_users_list.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class EventPage extends StatelessWidget {
  final int eventId;
  const EventPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
        final provider = BlocProvider.of<EventBloc>(context);

        if(state is EventInitialState){
          provider.searchEvent(eventId);
        }
        //first part, the users list
        final Widget userList = switch(state){
          SearchingEventState _ => const CircularProgressIndicator(),
          EventUsersRetrievedState s => EventUsersList(users: s.users),
          EventFailureState _ => const Text(AppStrings.errorRetrievingUsers),
          EventState _ => const CircularProgressIndicator(),
        };

        final Widget logsHistory = switch(state){
          SearchingEventState _ => const CircularProgressIndicator(),
          EventState _ => const CircularProgressIndicator(),
        };

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            userList,
            logsHistory
          ],
        );
      }),
    );
  }
}
