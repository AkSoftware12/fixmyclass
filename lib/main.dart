import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixmyclass/UI/Login/SplashScreen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background message: ${message.notification?.title}");
}
Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: 'AIzaSyBW0lyEeUM43UGGLb575YPi0qq0BcehC0w',
  //       appId: '1:675723129823:android:b9a7ab387d1d870e84ca6a',
  //       messagingSenderId: '675723129823',
  //       projectId: 'fix-my-class',
  //       storageBucket: "fix-my-class.firebasestorage.app",
  //     ),
  //   );
  // } else if (Platform.isAndroid) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: 'AIzaSyBW0lyEeUM43UGGLb575YPi0qq0BcehC0w',
  //       appId: '1:675723129823:android:b9a7ab387d1d870e84ca6a',
  //       messagingSenderId: '675723129823',
  //       projectId: 'fix-my-class',
  //       storageBucket: "fix-my-class.firebasestorage.app",
  //     ),
  //   );  } else if (Platform.isIOS) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: 'AIzaSyBW0lyEeUM43UGGLb575YPi0qq0BcehC0w',
  //       appId: '1:675723129823:android:b9a7ab387d1d870e84ca6a',
  //       messagingSenderId: '675723129823',
  //       projectId: 'fix-my-class',
  //       storageBucket: "fix-my-class.firebasestorage.app",
  //     ),
  //   );  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBW0lyEeUM43UGGLb575YPi0qq0BcehC0w',
        appId: '1:675723129823:android:b9a7ab387d1d870e84ca6a',
        messagingSenderId: '675723129823',
        projectId: 'fix-my-class',
        storageBucket: "fix-my-class.firebasestorage.app",
      ),
    );

  } else {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown, // agar upside-down bhi allow karna ho toh uncomment karo
  ]);

  await  NotificationService.initNotifications();

  FirebaseMessaging.instance.getToken().then((token) {
    print("🔥 FCM Token: $token");
  });

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 12 / modern base
      minTextAdapt: true,
      // splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  SplashScreen(),
        );
      },
    );

  }
}

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// 🔹 Initialize Notifications
  static Future<void> initNotifications() async {
    // Request Permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: true,
      announcement: true,
      carPlay: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("✅ Push Notifications Enabled");

      // iOS setup
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        print("📱 APNS Token: $apnsToken");
      }

      // Get FCM Token
      String? token = await _firebaseMessaging.getToken();
      print("📲 FCM Token: $token");

      // Background handler must be top-level
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
      FirebaseMessaging.onMessage.listen(_onMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

      // Init Local Notifications
      await _initLocalNotifications();
    } else {
      print("❌ Push Notifications Denied");
    }
  }

  /// 🔹 Foreground Notification
  static void _onMessage(RemoteMessage message) {
    print("📩 Foreground Notification: ${message.notification?.title}");
    _showLocalNotification(message);
  }

  /// 🔹 Notification Tap
  static void _onMessageOpenedApp(RemoteMessage message) {
    print("📩 Notification Clicked: ${message.notification?.title}");

    if (navigatorKey.currentContext != null) {
      Map<String, dynamic> data = message.data;
      if (data.containsKey('screen')) {
        String screen = data['screen'];
        if (screen == 'notification') {
          // Example Navigation
          // Navigator.push(
          //   navigatorKey.currentContext!,
          //   MaterialPageRoute(builder: (_) => NotificationScreen()),
          // );
        }
      }
    }
  }

  /// 🔹 Background Notification Handler
  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    print("📩 Background Notification: ${message.notification?.title}");
  }

  /// 🔹 Initialize Local Notifications
  static Future<void> _initLocalNotifications() async {
    // Create Android Channel (required for Android 8.0+)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // must be unique
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      sound: null, // use default system sound
    );

    // Register the channel
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iOSSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final String? payload = response.payload;
        if (payload != null) {
          print('🔹 Notification payload: $payload');
          // You can parse payload and navigate accordingly
        }
      },
    );

    print("✅ Local Notification Channel Initialized");
  }

  /// 🔹 Show Local Notification
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;
    final apple = message.notification?.apple;
    final imageUrl = android?.imageUrl ?? apple?.imageUrl;

    BigPictureStyleInformation? bigPictureStyle;
    if (Platform.isAndroid && imageUrl != null && imageUrl.isNotEmpty) {
      final String largeIconPath = await _downloadAndSaveFile(imageUrl, 'largeIcon');
      final String bigPicturePath = await _downloadAndSaveFile(imageUrl, 'bigPicture');
      bigPictureStyle = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        contentTitle: notification?.title,
        summaryText: notification?.body,
      );
    }

    // iOS details (optional image)
    DarwinNotificationDetails? iosDetails;
    if (Platform.isIOS) {
      iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        attachments: imageUrl != null && imageUrl.isNotEmpty
            ? [DarwinNotificationAttachment(await _downloadAndSaveFile(imageUrl, 'attach'))]
            : null,
      );
    }

    // Android details
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // must match channel id
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      styleInformation: bigPictureStyle,
    );

    NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      notification?.title,
      notification?.body,
      details,
      payload: json.encode(message.data),
    );
  }

  /// 🔹 Download file for image notifications
  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  /// 🔹 Optional: Handle silent data notifications
  static Future<void> _handleSilentNotification(Map<String, dynamic> data) async {
    print("🔇 Silent notification received: $data");
    // Do background logic (e.g., fetch new data)
  }
}
