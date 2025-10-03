import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/color.dart';
import '../../../Utils/string.dart';
import '../../BottomNavigationBar/Student/studentBottomNvaigationBar.dart';
import '../Login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final userData = prefs.getString("user");

    await Future.delayed(const Duration(seconds: 4)); // splash delay

    if (mounted) {
      if (token != null && userData != null) {
        // user already logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => BottomNavigationBarScreen()),
        );
      } else {
        // no login found
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150.sp,
              width: 150.sp,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.sp))
              ),
              child:   ClipRRect(
                borderRadius: BorderRadius.circular(20.sp),

                child: Image.asset(
                  'assets/playstore.png',
                  width: 130.sp,
                  height: 130.sp,
                ),
              ),
            ),
            // Logo image

            SizedBox(height: 10.sp), // Spacing between logo and app name
            // App name
            // Text(
            //   AppStrings.appName, // Replace with your app name
            //   style: GoogleFonts.roboto(
            //     fontSize: 12.sp,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white, // White text for contrast
            //   ),
            // ),

            SizedBox(height: 20.sp), // Spacing before loader
            CupertinoActivityIndicator(
              radius: 25,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}