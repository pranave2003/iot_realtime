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
 initOneSignal();
  runApp(const MyApp());
}

Future<void> initOneSignal() async {
  OneSignal.Debug.setLogLevel(
    kDebugMode ? OSLogLevel.verbose : OSLogLevel.none,
  );

  OneSignal.initialize("appId");

  final id = OneSignal.User.pushSubscription.id;

  if (id != null) {
   print('///////////////////////////////////////////////////////////$id');
  }
  else{
    print("///////////////////////nothing/////////////");
  }

  await OneSignal.Notifications.requestPermission(true);
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
