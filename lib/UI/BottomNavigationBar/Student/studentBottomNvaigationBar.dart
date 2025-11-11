import 'dart:convert';
import 'package:fixmyclass/UI/BottomNavigationBar/Student/Notification/notification.dart';
import 'package:fixmyclass/UI/BottomNavigationBar/Student/WeeklyProgressReport/weekly_report_screen.dart';
import 'package:fixmyclass/Utils/HexColorCode/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/color.dart';
import '../../../Utils/string.dart';
import '../../Login/Login/login.dart';
import 'LiveClassList/live_class_list.dart';
import 'Location/location_screen.dart';
import 'SeeAll/AllCourse/all_course_screen.dart';
import 'StudentCourse/student_course.dart';
import 'StudentHome/student_home.dart';
import 'StudentNotes/student_notes.dart';
import 'StudentPractice/AllPracticsList/all_practics_list.dart';
import 'StudentPractice/PracticesSetsList/practices_set_list.dart';
import 'StudentPractice/student_practice.dart';
import 'StudentProfile/student_profile.dart';
import 'StudentQuiz/QuizList/quiz_list.dart';
import 'StudentQuiz/student_quiz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _HomePageState();
}

class _HomePageState extends State<BottomNavigationBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selected = 0;
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: CustomAppBar(branchName: 'Virat Coaching'),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: selected,
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() => selected = index);
        },
      ),

      body: SafeArea(
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(), // 👈 Swipe disable
          children: [
            StudentHomePage(),
            // AllCoursesScreen(appBar: 'appBar'),
            LiveClassScreen(appBar: '',),
            // CoursesScreen(),
            AllPracticsList(),
            // PracticeScreen(),
            AllQuizList(appBar: '',),
            // QuizPracticeScreen(),
            ProfileScreen(),
            //   const IVRCallScreen(),
            //   const HelplineScreen(),
            //   const SOSScreen(),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String branchName;

  const CustomAppBar({super.key, required this.branchName});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? city;

  @override
  void initState() {
    super.initState();
    _getCurrentCity();
  }

  Future<void> _getCurrentCity() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ✅ Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // ✅ Request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    // ✅ Get position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // ✅ Convert to city name
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      setState(() {
        city = placemarks.first.locality ?? 'Unknown';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.navyBlue,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          Builder(
            builder: (context) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4.sp,
                      offset: Offset(0, 2.sp),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.dashboard_rounded,
                    color: AppColors.navyBlue,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
          ),

          // ✅ Logo and Location Column
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LocationPickerScreen(),
                  ),
                );

                if (result != null && result is String) {
                  setState(() {
                    city = result; // ✅ Update city name instantly on AppBar
                  });
                }
              },

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 3.w),
                      Text(
                        widget.branchName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // ✅ Branch and City info with icons
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        city ?? 'Fetching...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        // Add notification icon for better engagement
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Stack(
                children: [
                  Icon(Icons.notifications, color: Colors.white),
                  // Optional: Add a badge for unread count
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12.sp,
                        minHeight: 12.sp,
                      ),
                      child: Text(
                        '3', // Dynamic unread count
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                );
              },
            ),
          ),
        ),
        // Add profile or settings icon
      ],
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.live_tv_sharp, 'label': 'Live Class'},
      {'icon': Icons.question_answer, 'label': 'Practice'},
      {'icon': Icons.quiz_outlined, 'label': 'Quizzes'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return SafeArea(
      child: Container(
        height: 60.h,
        // ✅ consistent across all screens (ScreenUtil handles DPI & ratio)
        decoration: BoxDecoration(color: AppColors.navyBlue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            final isSelected = currentIndex == index;

            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 70.w,
                decoration: BoxDecoration(
                  color: isSelected ? index==1? HexColor('FF0000'): HexColor('#00171f')
                  : Colors.transparent,
                  // borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index==1?
                    Icon(
                      items[index]['icon'] as IconData,
                    color:Colors.white,
                    // color:index==1? HexColor('FF0000'):Colors.white,
                      size: isSelected ? 22.sp : 22.sp,
                    ): Icon(
                      items[index]['icon'] as IconData,
                      color:Colors.white,
                      // color:index==1? HexColor('FF0000'):Colors.white,
                      size: isSelected ? 22.sp : 22.sp,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color:Colors.white
                        // index==1? HexColor('FF0000'):Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.navyBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(0)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 🔹 Drawer Close Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 25.sp),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // 🔹 Header Section
            _buildHeader(),

            Divider(thickness: 1.sp, color: Colors.grey.shade300),

            // 🔹 Menu List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                children: [
                  _buildTile(
                    icon: Icons.dashboard_rounded,
                    title: 'Dashboard',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildTile(
                    icon: Icons.quiz_rounded,
                    title: 'All Quizzes',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  AllQuizList(appBar: 'App',)),
                      );
                    },
                  ),
                  _buildTile(
                    icon: Icons.school_rounded,
                    title: 'Practice Sets',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  PracticeSetsScreen()),
                      );
                    },
                  ),
                  _buildTile(
                    icon: Icons.book_rounded,
                    title: 'Notes & Study Material',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  NotesMaterialsScreen()),
                      );
                    },
                  ),
                  _buildTile(
                    icon: Icons.insert_chart_rounded,
                    title: 'Weekly Reports',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  WeeklyReportScreen()),
                      );
                    },
                  ),
                  _buildTile(
                    icon: Icons.notifications_active_rounded,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NotificationScreen()),
                      );
                    },
                  ),
                  _buildTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About Institute',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  WeeklyReportScreen()),
                      );
                    },
                  ),
                  _buildTile(
                    icon: Icons.policy_rounded,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  WeeklyReportScreen()),
                      );
                    },
                  ),
                  _buildTile(
                    icon: Icons.support_agent_rounded,
                    title: 'Help & Support',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  WeeklyReportScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  // 🔹 Logout Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                      icon: Icon(Icons.logout, color: Colors.red, size: 22.sp),
                      label: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 🔹 App Version Text
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          'v${snapshot.data!.version}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Header Section =================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10.h),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [AppColors.primaryBlue, AppColors.navyBlue],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      // ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.sp,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset('assets/playstore.png', fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Ravikant Saini',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Student | NEET Batch 2025',
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  // ================= List Tile Reusable =================
  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(12.r),
          //   color: Colors.white,
          // ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 22.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
