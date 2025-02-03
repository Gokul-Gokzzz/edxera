import 'dart:convert';
import 'dart:io';

import 'package:edxera/utils/shared_pref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("onBackground: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
}

class MyNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel('high_importance_channel', 'High Importance Notification',
      description: 'This Channel is user for impoertant notifcation', importance: Importance.high);
  final _localNotification = FlutterLocalNotificationsPlugin();

  void handaleMessage(RemoteMessage? message) {
    if (message == null) return;

    // if (Preference.shared.getBool(Preference.login) ?? false) {
    //   Get.toNamed(AppRoutes.bottomScreen);
    // } else {
    //   Get.toNamed(AppRoutes.login);
    // }
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handaleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handaleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((event) {
      final notification = event;

      _localNotification.show(
          notification.notification.hashCode,
          notification.notification?.title ?? "",
          notification.notification?.body ?? "",
          NotificationDetails(
            android: AndroidNotificationDetails(_androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description, icon: '@mipmap/ic_launcher', priority: Priority.high, playSound: true),
          ),
          payload: jsonEncode(event.toMap()));
    });

    final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initLocalNotification() async {
    const iOSInitialize = DarwinInitializationSettings();
    const androidInitialize = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationsSettings = const InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await _localNotification.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload! != '' && notificationResponse.payload!.isNotEmpty) {}
      },
    );
  }

  Future<void> initNotification() async {
    try {
      await _firebaseMessaging.requestPermission();
      final fcmToken = Platform.isIOS ? await _firebaseMessaging.getAPNSToken() : await _firebaseMessaging.getToken();
      print('Firebase Token : $fcmToken');
      PrefData.setdfcmToken(fcmToken.toString());
      initPushNotification();
      initLocalNotification();
    } on Exception catch (e) {
      // TODO
    }
  }
}
