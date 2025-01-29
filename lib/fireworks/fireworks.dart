import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Catogory.dart';

class Fireworks extends StatefulWidget {
  const Fireworks({super.key});

  @override
  State<Fireworks> createState() => _FireworksState();
}

class _FireworksState extends State<Fireworks> {
  int firstRemainingTime = 60;
  int secondRemainingTime = 60;
  int thirdRemainingTime = 60;

  Timer? firstCountdownTimer;
  Timer? secondCountdownTimer;
  Timer? thirdCountdownTimer;

  // Start Timer for the first button
  void startFirstTimer() {
    if (firstCountdownTimer != null && firstCountdownTimer!.isActive) return;

    firstCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (firstRemainingTime > 0) {
          firstRemainingTime--;

          if (firstRemainingTime == 0) {
            print("blast f1///////////////////");
            toggleblast_f1();
          }
        } else {
          timer.cancel();
        }
      });
    });
  }

  // Start Timer for the second button
  void startSecondTimer() {
    if (secondCountdownTimer != null && secondCountdownTimer!.isActive) return;

    secondCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondRemainingTime > 0) {
          secondRemainingTime--;
          if (secondRemainingTime == 0) {
            print("blast f2///////////////////");
            toggleblast_f2();
          }
        } else {
          timer.cancel();
        }
      });
    });
  }

  // Start Timer for the third button
  void startThirdTimer() {
    if (thirdCountdownTimer != null && thirdCountdownTimer!.isActive) return;

    thirdCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (thirdRemainingTime > 0) {
          thirdRemainingTime--;
          if (thirdRemainingTime == 0) {
            print("blast f1///////////////////");
            toggleblast_f3();
          }
        } else {
          timer.cancel();
        }
      });
    });
  }

  // Reset Timer for the first button
  void resetFirstTimer() {
    firstCountdownTimer?.cancel();
    setState(() {
      firstRemainingTime = 60;
    });
  }

  // Reset Timer for the second button
  void resetSecondTimer() {
    secondCountdownTimer?.cancel();
    setState(() {
      secondRemainingTime = 60;
    });
  }

  // Reset Timer for the third button
  void resetThirdTimer() {
    thirdCountdownTimer?.cancel();
    setState(() {
      thirdRemainingTime = 60;
    });
  }

  @override
  void dispose() {
    firstCountdownTimer?.cancel();
    secondCountdownTimer?.cancel();
    thirdCountdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Catogory();
            },
          ));
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Blast.....💥🔥",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.amber,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // First Timer
          timerRow(
            "Assets/img.png",
            firstRemainingTime,
            startFirstTimer,
            resetFirstTimer,
          ),

          // Second Timer
          timerRow(
            "Assets/img_1.png",
            secondRemainingTime,
            startSecondTimer,
            resetSecondTimer,
          ),

          // Third Timer
          timerRow(
            "Assets/img_2.png",
            thirdRemainingTime,
            startThirdTimer,
            resetThirdTimer,
          ),
        ],
      ),
    );
  }

  /// Helper Method to Create Timer Rows
  Widget timerRow(String imagePath, int remainingTime, VoidCallback onStart,
      VoidCallback onReset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            Text(
              "${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 25),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: onReset,
                  child: const Text("Reset"),
                ),
                InkWell(
                  onTap: onStart,
                  child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        "Fire",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  bool isblastOn = false;
  void toggleblast_f1() async {
    setState(() {
      isblastOn = !isblastOn;
    });

    // Update the "led" key in Firebase
    await _databaseReference.child('Firework/f1').set(isblastOn);
  }

  bool isblastOn2 = false;
  void toggleblast_f2() async {
    setState(() {
      isblastOn2 = !isblastOn2;
    });

    // Update the "led" key in Firebase
    await _databaseReference.child('Firework/f2').set(isblastOn2);
  }

  bool isblastOn3 = false;
  void toggleblast_f3() async {
    setState(() {
      isblastOn3 = !isblastOn;
    });

    // Update the "led" key in Firebase
    await _databaseReference.child('Firework/f3').set(isblastOn);
  }
}
