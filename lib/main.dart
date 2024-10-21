import 'package:flutter/material.dart';
import 'package:web_admin/core/color_theme.dart';
import 'package:web_admin/core/menu_navigator/main_page.dart';
import 'package:web_admin/dep_injection.dart';

void main() {
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: MaterialTheme.darkMediumContrastScheme(),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}