import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/events/domain/entities/event_log_entity.dart';

class LogsPanel extends StatelessWidget{

  final List<EventLogEntity> logs;

  const LogsPanel({
    super.key,
    required this.logs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(AppStrings.logHistory),
          Expanded(
            child: SingleChildScrollView(
              child: Column( 
                children: logs.map((log){
                  final String action = log.isInside ? AppStrings.entered : AppStrings.exited;
                  return Container(
                    child: Text('${log.email} $action ${AppStrings.atTime} ${log.time}'),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

}