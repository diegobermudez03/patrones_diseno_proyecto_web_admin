import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';
import 'package:web_admin/features/sessions/presentation/widgets/enabled_session_tile.dart';


class EnabledSessionsWidget extends StatelessWidget{

  final List<SessionEntity> sessions;
  
  EnabledSessionsWidget({
    super.key,
    required this.sessions
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(AppStrings.activeSessions),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppStrings.email),
              Text(AppStrings.phone),
              Text(AppStrings.model),
              Text(AppStrings.action)
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: sessions.map((s)=>EnabledSessionTile(session: s)).toList(),
            ),
          )
        ],
      ),
    );
  }
}