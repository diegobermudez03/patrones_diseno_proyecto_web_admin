import 'package:flutter/material.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';

class DisabledSessionTile extends StatelessWidget{

  final SessionEntity session;
  final void Function(int, bool) callback;

  const DisabledSessionTile({
    super.key,
    required this.session,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final String sentence = '${session.user.email} ${AppStrings.wantsToLinkWithA} ${session.phone_model}';
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(sentence),
          TextButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
            onPressed: ()=>callback(session.id, true), 
            child: Text(AppStrings.enable)
          )
        ],
      ),
    );
  }
}