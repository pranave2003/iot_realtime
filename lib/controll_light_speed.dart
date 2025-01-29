import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Light_Fan extends StatefulWidget {
  const Light_Fan({super.key});

  @override
  Light_FanState createState() => Light_FanState();
}

class Light_FanState extends State<Light_Fan> {
  double ledBrightness = 0; // Initial brightness for LED (0-100)
  double fanSpeed = 0; // Initial speed for Fan (0-100)
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    fetchValues();
  }

  /// Fetch LED brightness and fan speed from Firebase
  void fetchValues() {
    // Fetch LED brightness
    _databaseReference.child('devices/led/brightness').onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      if (data != null) {
        setState(() {
          ledBrightness = (data as num).toDouble();
        });
      }
    });

    // Fetch Fan speed
    _databaseReference.child('devices/fan/speed').onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      if (data != null) {
        setState(() {
          fanSpeed = (data as num).toDouble();
        });
      }
    });
  }

  /// Update LED brightness in Firebase
  void updateLedBrightness(double value) async {
    setState(() {
      ledBrightness = value;
    });

    await _databaseReference.child('devices/led/brightness').set(ledBrightness);
  }

  /// Update Fan speed in Firebase
  void updateFanSpeed(double value) async {
    setState(() {
      fanSpeed = value;
    });

    await _databaseReference.child('devices/fan/speed').set(fanSpeed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control LED and Fan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LED Brightness
            Text(
              'LED Brightness: ${ledBrightness.toInt()}%',
              style: const TextStyle(fontSize: 20),
            ),
            Slider(
              value: ledBrightness,
              min: 0,
              max: 100,
              divisions: 100,
              label: '${ledBrightness.toInt()}%',
              onChanged: (value) {
                updateLedBrightness(value);
              },
            ),
            const SizedBox(height: 40),

            // Fan Speed
            Text(
              'Fan Speed: ${fanSpeed.toInt()}%',
              style: const TextStyle(fontSize: 20),
            ),
            Slider(
              value: fanSpeed,
              min: 0,
              max: 100,
              divisions: 100,
              label: '${fanSpeed.toInt()}%',
              onChanged: (value) {
                updateFanSpeed(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
