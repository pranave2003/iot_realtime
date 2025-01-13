import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ToggleScreen extends StatefulWidget {
  @override
  ToggleScreenState createState() => ToggleScreenState();
}

class ToggleScreenState extends State<ToggleScreen> {
  bool isLedOn = false;
  bool isFanOn = false; // Initial state of the fan
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    fetchFanStatus();
  }

  /// Fetch the fan status from Firebase
  void fetchFanStatus() {
    _databaseReference.child('fan').onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      if (data != null) {
        setState(() {
          isFanOn = data as bool;
        });
      }
    });
  }

  /// Toggle LED state and update in Firebase
  void toggleLed() async {
    setState(() {
      isLedOn = !isLedOn;
    });

    // Update the "led" key in Firebase
    await _databaseReference.child('led').set(isLedOn);
  }



  /// Toggle fan state and update in Firebase
  void toggleFan() async {
    setState(() {
      isFanOn = !isFanOn;
    });

    // Update the "fan" key in Firebase
    await _databaseReference.child('fan').set(isFanOn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Toggle Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LED Status
            Text(
              'LED is ${isLedOn ? "ON" : "OFF"}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleLed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isLedOn ? Colors.green : Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text(
                isLedOn ? 'Turn OFF LED' : 'Turn ON LED',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),

            // Fan Status
            Text(
              'Fan is ${isFanOn ? "ON" : "OFF"}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleFan,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFanOn ? Colors.green : Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text(
                isFanOn ? 'Turn OFF Fan' : 'Turn ON Fan',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
