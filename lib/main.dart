import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ios/onoff.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'k4UXcn8ovpQApivPD4LpoepPawL3vrXBGPzAMpL7',
      appId: '1:323336171190:web:2103019509b244df61c017',
      messagingSenderId: '323336171190',
      projectId: 'demo1-282df',
      databaseURL:
          'https://demo1-282df-default-rtdb.asia-southeast1.firebasedatabase.app/', // Add this
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ToggleScreen());
  }
}
