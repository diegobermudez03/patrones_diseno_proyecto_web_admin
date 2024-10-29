import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';
import 'package:web_admin/features/sessions/presentation/widgets/disabled_session_tile.dart';

class DisabledSessionsWidget extends StatelessWidget{
  final List<SessionEntity> sessions;
  
  DisabledSessionsWidget({
    super.key,
    required this.sessions
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(AppStrings.requests),
          SingleChildScrollView(
            child: Column(
              children: sessions.map((s)=>DisabledSessionTile(session: s)).toList(),
            ),
          )
        ],
      ),
    );
  }
}