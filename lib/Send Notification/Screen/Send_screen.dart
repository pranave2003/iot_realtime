import 'package:flutter/material.dart';

import '../Services/Notificationservice.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: "Title"),
            controller: title,
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: "Description"),
            controller: description,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  await NotificationService()
                      .Sendnotification(title.text, description.text);
                },
                child: const Text("Send to all Notification")),
          ),
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
              onPressed: () async {
                await NotificationService().Sendnotificationtoemulator();
              },
              child: const Text("Send One emulator")),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await NotificationService().Sendnotificationtopoco();
              },
              child: const Text("Send One poco")),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await NotificationService().Sendnotificationtomygroup();
              },
              child: const Text("Send To group"))
        ],
      ),
    );
  }
}
