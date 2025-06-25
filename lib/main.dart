import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vervefit/Screens/landing.dart';
import 'package:vervefit/Screens/loginpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xpwvamfskixdyswyquhk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhwd3ZhbWZza2l4ZHlzd3lxdWhrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA3NzAxMTEsImV4cCI6MjA2NjM0NjExMX0.DK3SBfPTmY6cIEpzkHUmT86ZFDyeO4HwhpUqr64QGYk',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VerveFit Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: Supabase.instance.client.auth.currentUser != null
          ? const LandingPage()
          : const LoginPage(),
    );
  }
}
