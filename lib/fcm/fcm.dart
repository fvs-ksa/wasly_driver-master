import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../component/general_component.dart';
import '../constant/const_color.dart';
import '../ui/main_screen/tabs_screen.dart';
import 'package:path_provider/path_provider.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
  // await Firebase.initializeApp();
  _onMessageStreamController.add(message.data);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
    print('on Opened ' + data.data.toString());

    handlePathByRoute(data.data);
  });
  print("Handling a background message: ${message.data}");
}

StreamController<Map<String, dynamic>> _onMessageStreamController =
StreamController.broadcast();

class FirebaseNotifications {
  late FirebaseMessaging _firebaseMessaging;

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void killNotification() {
    _onMessageStreamController.close();
  }

  late FlutterLocalNotificationsPlugin _notificationsPlugin;

  late Map<String, dynamic> _not;

  Future<void> setUpFirebase() async {

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage();

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(

        alert: true, badge: true, sound: true);
    // checkLastMessage();
    firebaseCloudMessagingListeners();

    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = const DarwinInitializationSettings(
        defaultPresentBadge: true,
        defaultPresentAlert: true,
        defaultPresentSound: true);
    var initSetting = InitializationSettings(android: android, iOS: ios);
    _notificationsPlugin.initialize(initSetting,
      // onDidReceiveBackgroundNotificationResponse:onSelectNotification ,
      // onDidReceiveNotificationResponse:onSelectNotification,
      // onSelectNotification: onSelectNotification
    );


  }

  // Future<void> checkLastMessage() async {
  //   RemoteMessage initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   if (initialMessage != null) {
  //     print(initialMessage.data.toString());
  //     handlePath(initialMessage.data);
  //   }
  // }
  BuildContext? context;
  Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print("TOOOKEN" + token!);
      fcmToken = token;
      print(fcmToken);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage data) {
      print('on message ${data.data['order_id']}');
      print('on message notification body ${data.notification?.body}');
      print('on message notification title ${data.notification?.title}');
      //String timeZone='Pm';
    //  data.sentTime!.hour>12?timeZone='Pm':timeZone='Am';

    //  String time='${data.sentTime?.hour}:${data.sentTime?.minute} $timeZone ';
    //  print(timeZone);
      //print(DateFormat.yMEd().add_jms().format(DateFormat("hh:mm").parse(time)));
      //print('on message notifications title ${data.sentTime?.hour}:${data.sentTime?.minute} $timeZone');
    //  notificationList.add(NotificationModel(title: data.notification?.title, subTitle: data.notification?.body,
         // timeZone: time));
      _onMessageStreamController.add(data.data);
      //  handlePath(data.data);

      _not = data.data;
      print(_not);

      showNotification(
          data.data, data.notification?.title, data.notification?.body);

      // if (Platform.isAndroid) {
      //   showNotificationWithAttachment(data.data, data.notification.title,
      //       data.notification.body, data.notification.android.imageUrl);
      // } else {
      //   showNotificationWithAttachment(data.data, data.notification.title,
      //       data.notification.body, data.notification.apple.imageUrl);
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
      print('on Opened ' + data.data.toString());

      handlePath(data.data);
    });
  }

  showNotification(
      Map<String, dynamic> _message, String? title, String? body) async {
    print("Notification Response : $_message");

    var androidt = const AndroidNotificationDetails(
        'braq', 'channel_name',
        priority: Priority.high,
        channelShowBadge: true,
        playSound: true,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher",
        enableVibration: true,
        enableLights: true,
        importance: Importance.max);
    var iost = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: androidt, iOS: iost);
    await _notificationsPlugin.show(0, title, body, platform, payload: "");
  }

  Future<void> showNotificationWithAttachment(Map<String, dynamic> _message,
      String title, String body, String imageUrl) async {
    print("Notification Response : $_message");
    var attachmentPicturePath = await _downloadAndSaveFile(
        imageUrl ?? 'https://via.placeholder.com/800x200',
        'attachment_img.jpg');
    var iOSPlatformSpecifics = DarwinNotificationDetails(
      attachments: [DarwinNotificationAttachment(attachmentPicturePath)],
    );
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachmentPicturePath),
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: '$body',
      htmlFormatSummaryText: true,
    );
    var androidChannelSpecifics = AndroidNotificationDetails(
      'braq',
      'channel_name',
      // 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    var notificationDetails = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
    print("notificationDetails $notificationDetails");
    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  void iOSPermission() {
    _firebaseMessaging.requestPermission(
        alert: true, announcement: true, badge: true, sound: true);
  }

  void handlePath(
      Map<String, dynamic> dataMap,
      //BuildContext context
      ) {
    handlePathByRoute(
      dataMap,
      // context
    );
  }

  Future<void> handlePathByRoute(
      Map<String, dynamic> dataMap,
      //BuildContext context
      ) async {
    print(dataMap);
    String orderId = dataMap["order_id"].toString();
    String userId = dataMap["user_id"].toString();
    String supplierId = dataMap["provider_id"].toString();
    String roomId = dataMap["chat_id"].toString();
    String type = dataMap["type"].toString();

    print(orderId);
    print(userId);
    print(supplierId);
    print(roomId);
    navigateForward(TabsScreen());
    // if (type == '6') {
    //
    //   // navigateForward(
    //   //     ChatScreen(
    //   //       orderId: orderId,
    //   //       chatId: roomId,
    //   //       supplierId: supplierId,
    //   //       userId: userId,
    //   //     )
    //   // );
    // }else if(supplierId == '9' || type =='1'){
    //   // navigateForward(NotificationScreen(
    //   //
    //   // ));
    // }
    // else{
    //   // navigateForward(DetailsScreen(
    //   //   orderId: orderId,
    //   //   userId: userId,
    //   //   roomId: roomId,
    //   //   supplierId: supplierId,
    //   // ));
    // }

  }

  void onSelectNotification(String payload) async {
    print(payload.toString());
    handlePath(_not);
  }
}
Future<void> handlePathByRoute(
    Map<String, dynamic> dataMap,
    //BuildContext context
    ) async {
  print(dataMap);
  String orderId = dataMap["order_id"].toString();
  String userId = dataMap["user_id"].toString();
  String supplierId = dataMap["provider_id"].toString();
  String roomId = dataMap["chat_id"].toString();
  String type = dataMap["type"].toString();

  print(orderId);
  print(userId);
  print(supplierId);
  print(roomId);
  navigateForward(TabsScreen());
  // if (type == '6') {
  //
  //   // navigateForward(
  //   //     ChatScreen(
  //   //       orderId: orderId,
  //   //       chatId: roomId,
  //   //       supplierId: supplierId,
  //   //       userId: userId,
  //   //     )
  //   // );
  // }else if(supplierId == '9' || type =='1'){
  //   // navigateForward(NotificationScreen(
  //   //
  //   // ));
  // }
  // else{
  //   // navigateForward(DetailsScreen(
  //   //   orderId: orderId,
  //   //   userId: userId,
  //   //   roomId: roomId,
  //   //   supplierId: supplierId,
  //   // ));
  // }

}