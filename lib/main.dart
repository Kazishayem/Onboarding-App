import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/location/location_screen.dart';
import 'screens/HomePage/home_screen.dart';
import 'screens/alarm/alarm_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding App',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/location': (context) => const LocationScreen(),
        '/alarm': (context) => const AlarmListScreen(),
      },
    );
  }
}
