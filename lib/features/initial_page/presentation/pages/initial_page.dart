import 'package:flutter/material.dart';
import 'package:web_admin/shared/widgets/app_bar.dart';

class InitialPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body:  Text("to do initial"),
    );
    
  }
}