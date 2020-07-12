import 'package:animations/home/view/home_screen.dart';
import 'package:animations/login/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
