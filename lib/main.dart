import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Auth/login_landing_page.dart';
import 'HexColorCode/HexColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  OnboardingScreen(),
        );
      },
    );

  }
}



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/student4.png',
      'title': 'Your Learning Journey Starts Here',
      'desc': "Step into a world of knowledge where every day brings new discoveries.Let’s grow, one lesson at a time."
    },
    {
      'image': 'assets/student5.png',
      'title': 'Seekhna ab hua aasan',
      'desc': 'Courses, quizzes, aur progress tracking – sab kuch ek hi jagah. Apne lakshya tak pahuchna ab aur bhi simple hai.'
    },
    {
      'image': 'assets/student3.png',
      'title': 'Get Started',
      'desc': 'Apni journey start karne ke liye profile complete karein aur apne pehle course ka chayan karein.'
    },
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginLandingpage()),
      );
      // Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: HexColor('#1a434e'),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _pages[index]['image']!,
                      height: 200.sp,
                      width: 200.sp,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      _pages[index]['title']!,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 0),
                    Text(
                      _pages[index]['desc']!,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ?   HexColor('#1a434e') : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                color: HexColor('#1a434e'),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: CupertinoColors.white,
                  width: 3, // Responsive border width
                ),
              ),
              child: CupertinoButton(
                onPressed: _nextPage,
                padding: const EdgeInsets.symmetric(vertical: 16),
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent, // Set transparent to use container color
                child: Text(
                  _currentIndex == _pages.length - 1 ? 'Get Started' : 'Next',
                  style:  TextStyle(fontSize: 16.sp, color: CupertinoColors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          if (_currentIndex < _pages.length - 1)
            Positioned(
              top: 50,
              right: 24,
              child: GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                child:  Text(
                  'Skip',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
