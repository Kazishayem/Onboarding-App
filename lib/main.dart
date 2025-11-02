import 'package:flutter/material.dart';
import 'package:onboarding_app/screens/dashboard/DashboardPage.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/HomePage/home_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:onboarding_app/services/alarm_service.dart';

//
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final AlarmService alarmService = AlarmService();
//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await alarmService.init();

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
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
