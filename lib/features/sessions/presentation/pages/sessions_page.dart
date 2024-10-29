import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_bloc.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_states.dart';
import 'package:web_admin/features/sessions/presentation/widgets/enabled_sessions_widget.dart';
import 'package:web_admin/features/sessions/presentation/widgets/disabled_sessions_widget.dart';

class SessionsPage extends StatelessWidget{

  SessionsPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SessionsBloc, SessionsState>(builder: (context, state){
        final provider = BlocProvider.of<SessionsBloc>(context);
        if(state is SessionsInitalState){
          provider.getSessions();
        }
        final Widget enabledSessions = switch(state){
          SessionsRetrievedState(enabledSessions: final en) => EnabledSessionsWidget(sessions: en, callback: actionOnSession(provider),),
          SessionsRetrievingFailure() => const Center(child: Text(AppStrings.apiError)),
          SessionsState _ => const Center(child: CircularProgressIndicator())
        };
        final Widget disabledSessions = switch(state){
          SessionsRetrievedState(disabledSessions: final dis) => DisabledSessionsWidget(sessions: dis, callback: actionOnSession(provider),),
          SessionsRetrievingFailure() => const Center(child: Text(AppStrings.apiError)),
          SessionsState _ => const Center(child: CircularProgressIndicator())
        };
        return Column(
          children: [
            Text(AppStrings.sessions),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 3,child: enabledSessions),
                Expanded(flex: 2,child: disabledSessions),
              ],
            )
          ],
        );
      })
    );
  }


  void Function(int, bool) actionOnSession(SessionsBloc provider){
    final void Function(int, bool) callback = (id, enable)=>provider.changeSession(id, enable);
    return callback;
  }
}