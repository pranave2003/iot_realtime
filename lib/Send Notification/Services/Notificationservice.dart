import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ios/Send%20Notification/Keys/Keys.dart';

class NotificationService {
  String Url = 'https://api.onesignal.com/notifications?c=push';
  Sendnotification(String title, String description) async {
    try {
      var response = await http.post(Uri.parse(Url),
          headers: {
            "Authorization": "Key ${Apikeys.Apikey}",
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: jsonEncode({
            "app_id": Apikeys.Appid,
            "contents": {
              "en": description,
            },
            "included_segments": ['Total Subscriptions'],
            "headings": {"en": title},
            "subtitle": {"en": "Sub title"},
            "data": {"screen": "/category"},
            "small_icon": "Assets/img.png",
            "big_picture":
                "https://static.vecteezy.com/system/resources/thumbnails/025/181/412/small/picture-a-captivating-scene-of-a-tranquil-lake-at-sunset-ai-generative-photo.jpg",
          }));
      if (response.statusCode == 200) {
        print("Notification send successfully ${response.body}");
      } else {
        print(
            "Notification faild  with status code ${response.statusCode} and message is ${response.body}");
      }
    } on Exception catch (e) {
      print("Error Occured : $e");
    }
  }

  Sendnotificationtoperson(String title, String description) async {
    try {
      var response = await http.post(Uri.parse(Url),
          headers: {
            "Authorization": "Key ${Apikeys.Apikey}",
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: jsonEncode({
            "app_id": Apikeys.Appid,
            "contents": {
              "en": description,
            },
            "included_segments": ['Total Subscriptions'],
            "headings": {"en": title},
            "subtitle": {"en": "Sub title"},
            "data": {"screen": "/category"},
            "small_icon": "Assets/img.png",
            "big_picture":
                "https://static.vecteezy.com/system/resources/thumbnails/025/181/412/small/picture-a-captivating-scene-of-a-tranquil-lake-at-sunset-ai-generative-photo.jpg",
          }));
      if (response.statusCode == 200) {
        print("Notification send successfully ${response.body}");
      } else {
        print(
            "Notification faild  with status code ${response.statusCode} and message is ${response.body}");
      }
    } on Exception catch (e) {
      print("Error Occured : $e");
    }
  }
}
