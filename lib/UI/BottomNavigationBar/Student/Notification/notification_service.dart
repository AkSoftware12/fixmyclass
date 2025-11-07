import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Request permission
    await _firebaseMessaging.requestPermission();

    // Initialize local notification
    const AndroidInitializationSettings initSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
    InitializationSettings(android: initSettingsAndroid);
    await _localNotifications.initialize(initSettings);

    // Foreground message listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        showLocalNotification(notification.title, notification.body);
        saveNotification(notification.title ?? '', notification.body ?? '');
      }
    });
  }

  static Future<void> showLocalNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'FixMyClass Channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    await _localNotifications.show(0, title, body, details);
  }

  static Future<void> saveNotification(String title, String body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> existing = prefs.getStringList('notifications') ?? [];
    Map<String, String> newData = {"title": title, "body": body};
    existing.add(jsonEncode(newData));
    await prefs.setStringList('notifications', existing);
  }

  static Future<List<Map<String, String>>> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = prefs.getStringList('notifications') ?? [];
    return data.map((e) => Map<String, String>.from(jsonDecode(e))).toList();
  }
}
