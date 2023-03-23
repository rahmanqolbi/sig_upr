import 'package:catatanku/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatanku',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF252525),
          fontFamily: 'Open Sans'),
      home: const MainScreen(),
    );
  }
}
