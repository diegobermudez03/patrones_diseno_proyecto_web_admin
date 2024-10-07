import 'package:flutter/material.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class EventsPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Text("TO DO"),
    );
  }
}