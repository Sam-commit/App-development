import 'package:flutter/material.dart';
import 'screens/Loading screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF03A9F4),
        accentColor: Color(0xFFFFEB3B),

      ),
      home: LoadingScreen(),
    );
  }
}
