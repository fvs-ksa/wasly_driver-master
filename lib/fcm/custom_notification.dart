
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../utiles/shared_pref.dart';



pushNotification(String title,String mBody) async{
  CacheHelper.init();
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  var headers = {'Authorization':'key= AAAA_u4v9l8:APA91bHq4I-Lh4y4ZylSxTMWxM5I1JvTK43TRCiljG7cjapWG56NZXq5kuK2UvtZeOzo-m87syjQsLN0gpg0yQvK0jOp2ZwcFTpiNLDxlJmgjyDjSIYaEfpCUph00mMfMv7GJ0ZkUmfz','Content-Type':'application/json'};
  var body = jsonEncode( {"to": CacheHelper.getData(key: 'fcmToken'),
    'notification': {'title':title,'body': mBody}});
  var response = await http.post(url, body: body,headers: headers);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'my_channel', // id
  'My Channel', // title
  // 'Important notifications from my server.', // description
  importance: Importance.high,
);

class NotificationsHelper {
  static Future init() async {
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                icon: 'ic_launcher.png',
              ),
            ));
      }
    });
  }
}