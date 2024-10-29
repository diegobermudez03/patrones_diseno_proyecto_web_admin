import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_bloc.dart';
import 'package:web_admin/features/sessions/presentation/state/sessions_states.dart';
import 'package:web_admin/features/sessions/presentation/widgets/enabled_sessions_widget.dart';
import 'package:web_admin/features/sessions/presentation/widgets/disabled_sessions_widget.dart';

class SessionsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SessionsBloc, SessionsState>(builder: (context, state){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 3,child: EnabledSessionsWidget()),
            Expanded(flex: 2,child: DisabledSessionsWidget()),
          ],
        );
      })
    );
  }
}