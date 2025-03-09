// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:voxcue_app/screens/login_screen.dart';
import 'package:voxcue_app/screens/register_screen.dart';
import 'package:voxcue_app/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voxcue App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => const HomePage(), // Use HomePage as the home screen
      },
    );
  }
}
