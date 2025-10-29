import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fixmyclass/UI/Login/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyASMmPy8mhABFOGTEHmkI-vv559WTiw814',
        appId: '1:164105009272:android:67e2bc460fd3b44376158d',
        messagingSenderId: '164105009272',
        projectId: 'cjm-shimla-parent',
        storageBucket: "cjm-shimla-parent.firebasestorage.app",
      ),
    );
  } else {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
  }

  // Sirf portraitUp (normal) aur portraitDown (ulot ke saath) chahiye toh:
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown, // agar upside-down bhi allow karna ho toh uncomment karo
  ]);
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

