import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onboarding_app/services/location_service.dart';
import 'package:onboarding_app/services/alarm_service.dart';
import 'package:onboarding_app/widgets/alarm_tile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  String locationText = "Add your location";
  final LocationService _locationService = LocationService();
  final AlarmService _alarmService = AlarmService();
  Stream<String>? _locationStream;

  final List<Map<String, dynamic>> _alarms = [];

  @override
  void initState() {
    super.initState();
    _alarmService.init();
  }

  void startLocationStream() {
    setState(() {
      _locationStream = _locationService.getLiveLocation();
    });
  }

  Future<void> _pickTimeAndSetAlarm() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final alarmTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      try {
        await _alarmService.scheduleAlarm(alarmTime);
        setState(() {
          _alarms.add({
            "time": DateFormat('hh:mm a').format(alarmTime),
            "date": DateFormat('EEE dd MMM yyyy').format(alarmTime),
            "enabled": true,
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Alarm set for ${DateFormat('hh:mm a').format(alarmTime)}",
            ),
          ),
        );
      } catch (e) {
        debugPrint("⚠️ Alarm scheduling failed: $e");
        setState(() {
          _alarms.add({
            "time": DateFormat('hh:mm a').format(alarmTime),
            "date": DateFormat('EEE dd MMM yyyy').format(alarmTime),
            "enabled": false,
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: _pickTimeAndSetAlarm,
        child: const Icon(Icons.add_alarm),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 20, 14, 68),
              Color.fromARGB(255, 19, 15, 74),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selected Location",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: startLocationStream,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StreamBuilder<String>(
                          stream: _locationStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                "Fetching location...",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Poppins',
                                ),
                              );
                            } else if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: const TextStyle(color: Colors.white70),
                              );
                            } else {
                              return Text(
                                locationText,
                                style: const TextStyle(color: Colors.white70),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Alarms",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: _alarms.length,
                  itemBuilder: (context, index) {
                    final alarm = _alarms[index];
                    return AlarmTile(
                      time: alarm["time"],
                      date: alarm["date"],
                      enabled: alarm["enabled"],
                      onToggle: (value) {
                        setState(() {
                          _alarms[index]["enabled"] = value;
                        });

                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Alarm re-enabled for ${alarm["time"]}",
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Alarm disabled for ${alarm["time"]} ",
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
