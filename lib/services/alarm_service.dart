import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
    tz.initializeTimeZones();
  }

  Future<void> scheduleAlarm(DateTime dateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      '⏰ Alarm',
      'Time’s up!',
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel_id',
          'Alarm Notifications',
          channelDescription: 'Alarm notification channel',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'alarm_payload',
    );
  }
}
