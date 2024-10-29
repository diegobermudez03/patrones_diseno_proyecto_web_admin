import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_admin/core/strings/app_strings.dart';
import 'package:web_admin/features/sessions/domain/entities/session_entity.dart';

class EnabledSessionTile extends StatelessWidget{

  final SessionEntity session;
  final void Function(int, bool) callback;

  const EnabledSessionTile({
    super.key,
    required this.session,
    required this.callback
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(session.user.email),
        Text(session.user.number),
        Text(session.phone_model),
        TextButton(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
          onPressed: ()=>callback(session.id, false), 
          child: const Text(AppStrings.disable)
        )
      ],
    );
  }
}