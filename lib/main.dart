import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_2025/login.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://xqycaxmguymimbbprzrr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhxeWNheG1ndXltaW1iYnByenJyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MDg2NTEsImV4cCI6MjA1NDk4NDY1MX0.SFUP7WFH9cgMITWGqulapAFJAn8vFC5H9Tu5vunOzfw',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login()
        
    );
  }
}
