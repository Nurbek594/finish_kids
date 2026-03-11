import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KidsPsychApp());
}

class KidsPsychApp extends StatelessWidget {
  const KidsPsychApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bolalar Psixologiyasi',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}