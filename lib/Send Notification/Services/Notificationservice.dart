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

  List emuids = [
    "12cfc231-5a06-43c2-b449-e49f41aa3df6",
  ];

  Sendnotificationtoemulator() async {
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
              "en": "Emulator description",
            },
            // "included_segments": ['Total Subscriptions'],
            "headings": {"en": "Emulator message"},
            "subtitle": {"en": "Sub title"},
            "data": {"screen": "/category"},
            "small_icon": "Assets/img.png",
            "include_player_ids": emuids,
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

  List pocoids = [
    "61f1c72d-5bb2-4d92-96df-1e6d87b6ea0f",
  ];
  Sendnotificationtopoco() async {
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
              "en": "poco description",
            },
            // "included_segments": ['Total Subscriptions'],
            "headings": {"en": "Poco testing"},
            "subtitle": {"en": "Sub title"},
            "data": {"screen": "/category"},
            "small_icon": "Assets/img.png",
            "include_player_ids": pocoids,
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

  List Mygroup = [
    "61f1c72d-5bb2-4d92-96df-1e6d87b6ea0f",
    "12cfc231-5a06-43c2-b449-e49f41aa3df6"
  ];

  Sendnotificationtomygroup() async {
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
              "en": "Snt group",
            },
            // "included_segments": ['Total Subscriptions'],
            "headings": {"en": "Group message"},
            "subtitle": {"en": "Sub title"},
            "data": {"screen": "/category"},
            "small_icon": "Assets/img.png",
            "include_player_ids": Mygroup,
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
