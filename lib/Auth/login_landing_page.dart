import 'package:fixmyclass/Auth/LoginTeacherPage/login_teacher_page.dart';
import 'package:fixmyclass/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'LoginStudentPage/login_student_page.dart';

class LoginLandingpage extends StatefulWidget {
  const LoginLandingpage({super.key});

  @override
  State<LoginLandingpage> createState() => _LoginLandingpageState();
}

class _LoginLandingpageState extends State<LoginLandingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 400, // Responsive max width
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/login_bg.jpg',
                        height: 200.sp,
                        width: 200.sp,
                        fit: BoxFit.contain,
                      ),

                      // Title
                      Text(
                        'Welcome to Fix My Class ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Choose your login type',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Student Login Button
                      _buildAnimatedButton(
                        context,
                        text: 'Student Login',
                        icon: Icons.school,
                        color:AppColors.primary,
                        onPressed: () {
                          print("Student Login Selected");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginStudentPage()));
                        },
                      ),
                      const SizedBox(height: 20),
                      // Teacher Login Button
                      _buildAnimatedButton(
                        context,
                        text: 'Teacher Login',
                        icon: Icons.person,
                        color: AppColors.primary,
                        onPressed: () {
                          print("Teacher Login Selected");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginTeacherPage()));
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),


          ],
        ),



      ),
    );
  }

  Widget _buildAnimatedButton(
      BuildContext context, {
        required String text,
        required IconData icon,
        required Color color,
        required VoidCallback onPressed,
      }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1.0, end: 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          shadowColor: color.withOpacity(0.4),
        ),
      ),
    );
  }
}