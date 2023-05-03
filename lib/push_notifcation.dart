import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationManagger {
  // PushNotificationManagger._();
  // factory PushNotificationManagger()=>_instance;
  // static final PushNotificationManagger _instance=PushNotificationManagger._();
  // final FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;
  // bool _initialized=false;
  // Future init()async{
  //   if(!_initialized){
  //     //ios
  //     _firebaseMessaging.requestPermission();
  //
  //     String token=await _firebaseMessaging.getToken();
  //
  //     log('my new token = $token');
  //     _initialized=true;
  //     return token;
  //   }
  // }
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)  async{
    AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings('@mipmap/launcher_icon');

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(onDidReceiveLocalNotification:
        (int? id, String? title, String? body, String? payload) async {
      // display a dialog with the notification details, tap ok to go to another page
    });

    const LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          log('notification payload: $payload');
        }
        //NAVIGATE TO SPECIFIC SCREEN BASED ON PAYLOAD
        // await Navigator.push(
        //   context,
        //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
        // );
      },
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((message) {
      print(
          '================================ FOREGROUND NOTIFICATION ================================');
      print(message.data);
      print('Notification title: ${message.notification?.title}');
      print('Notification body: ${message.notification?.body}');
      showNotification(
          message: message,
          fln: flutterLocalNotificationsPlugin,
          payload: message.data['type']);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(
          '================================ if the app has opened from a background state (not terminated) NOTIFICATION ================================');
      print(message.data);
      print('Notification title: ${message.notification?.title}');
      print('Notification body: ${message.notification?.body}');
      showNotification(
          message: message,
          fln: flutterLocalNotificationsPlugin,
          payload: message.data['type']);
    });
  }

  static Future<void> showNotification({
    required RemoteMessage message,
    required FlutterLocalNotificationsPlugin fln,
    String? payload,
  }) async {
     AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'high_channel',
      'High Importance Notification',
      channelDescription: 'This channel is for important notification',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      enableVibration: true,
    );
     NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await fln.show(0, message.notification?.title, message.notification?.body,
        notificationDetails,
        payload: payload);
  }
}