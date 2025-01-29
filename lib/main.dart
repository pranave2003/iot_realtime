import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'firebase_options.dart';
import 'fireworks/Catogory.dart';
import 'fireworks/fireworks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("fe4c7795-1d79-4d6e-b288-61ffc04b2a98");
  OneSignal.Notifications.requestPermission(true);
 await initOneSignal();
  runApp(const MyApp());
}

Future<void> initOneSignal() async {


  // Wait a moment before getting Player ID
  await Future.delayed(Duration(seconds: 2));

  final id = OneSignal.User.pushSubscription.id;

  if (id != null) {
    print('✅ OneSignal Player ID: $id');
  } else {
    print("❌ Player ID is null. The user may not be subscribed yet.");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorkey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? Screen;
    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      Screen = data?['screen'];
      if (Screen != null) {
        navigatorkey.currentState?.pushNamed(Screen!);
      }
    });
    return MaterialApp(
      navigatorKey: navigatorkey,
      initialRoute: '/',
      routes: {
        '/': (context) => const Fireworks(),
        '/category': (context) => const Catogory()
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
