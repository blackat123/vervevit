import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vervefit/Screens/history_booking_page.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: Supabase.instance.client.auth.currentUser != null
          ? const HistoryBookingPage()
          : const LoginPage(),
    );
  }
}
