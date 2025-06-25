import 'package:flutter/material.dart';
import 'Screens/landing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VerveFit',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const LandingPage(), // Ganti ke landing page
    );
  }
}
