import 'package:companion/function.dart';
import 'package:flutter/material.dart';
import 'package:companion/homepage.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: functions(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

