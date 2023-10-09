import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  NotificationService() {
    initializePlatformNotifications();
  }

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    try {
      bool? hasPermission = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
      if (hasPermission == null || !hasPermission) {
        print("No notification permission while clicking notification");
      }
    } catch (err) {
      print("Notification permmission err: $err");
    }

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        print(
            "xxxxxxxxxxxxxxxxxxxx Debug: Notification clicked ${response.payload}");
        // todo click
      },
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('1111111111111111111111111cccid $id');
  }

  late void Function(String) dataLinkCallBack;

  void setDataLinkListener({required Function(String) callback}) {
    dataLinkCallBack = callback;
  }

  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    required Map<String, dynamic> payload,
  }) async {
    final platformChannelSpecifics = await _notificationDetails();

    // serialize payload
    String payloadString = jsonEncode(payload);

    await _localNotifications.show(
        id, title ?? "", body ?? "", platformChannelSpecifics,
        payload: payloadString);
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      '1',
      'High Importance Notifications',
      groupKey: 'com.example.call_status_recording_project',
      channelDescription: 'channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: false,
      //sound: RawResourceAndroidNotificationSound('notificationsound'),
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      behaviorSubject.add(details.notificationResponse!.payload!);
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    return platformChannelSpecifics;
  }
}
