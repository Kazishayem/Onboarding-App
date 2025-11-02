import 'package:flutter/material.dart';

class AlarmTile extends StatelessWidget {
  final String time;
  final String date;
  final bool enabled;
  final Function(bool) onToggle;

  const AlarmTile({
    Key? key,
    required this.time,
    required this.date,
    required this.enabled,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(date, style: const TextStyle(color: Colors.black)),
            ],
          ),

          Switch(
            value: enabled,
            onChanged: onToggle,
            activeTrackColor: Colors.lightGreen,
          ),
        ],
      ),
    );
  }
}
