import 'dart:convert';
import 'package:fixmyclass/Utils/HexColorCode/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/color.dart';
import '../../../Utils/string.dart';
import '../../Login/Login/login.dart';
import 'Location/location_screen.dart';
import 'SeeAll/AllCourse/all_course_screen.dart';
import 'StudentCourse/student_course.dart';
import 'StudentHome/student_home.dart';
import 'StudentPractice/student_practice.dart';
import 'StudentProfile/student_profile.dart';
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
    return  Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar:  CustomAppBar(branchName: 'Virat Coaching',),
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
            AllCoursesScreen(appBar: 'appBar',),
            // CoursesScreen(),
            PracticeScreen(),
            QuizPracticeScreen(),
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
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

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
                  icon: Icon(Icons.dashboard_rounded, color: AppColors.navyBlue),
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
                  MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
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

                      Icon(Icons.location_on_rounded,
                                               color:Colors.white
                          , size: 14.sp),
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
              color:  Colors.grey
                  .withOpacity(0.3),
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
                      constraints: BoxConstraints(minWidth: 12.sp, minHeight: 12.sp),
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
                // Handle notifications
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
      {'icon': Icons.book, 'label': 'Courses'},
      {'icon': Icons.question_answer, 'label': 'Practice'},
      {'icon': Icons.quiz_outlined, 'label': 'Quizzes'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return SafeArea(
      child: Container(
        height: 60.h, // ✅ consistent across all screens (ScreenUtil handles DPI & ratio)
        decoration: BoxDecoration(
          color: AppColors.navyBlue,
        ),
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
                  color: isSelected ? HexColor('#00171f') : Colors.transparent,
                  // borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: Colors.white,
                      size: isSelected ? 22.sp : 22.sp,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w600,
                        color: Colors.white,
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
      // Use a subtle, light background
      backgroundColor: AppColors.lightGray,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(0.0)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 20.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black,size: 25.sp,),
                    onPressed: () {
                      Navigator.pop(context); // Drawer band karega
                    },
                  ),
                ],
              ),
            ),

            // Header
            _buildHeader(),
            Divider(
              thickness: 2.sp,
              color: Colors.grey.shade300,
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding:  EdgeInsets.symmetric(horizontal: 5.sp),
                children: [
                  _buildListTile(
                    context: context,
                    icon: Icons.person,
                    title: 'Profile',
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context)=> ProfileScreen()));
                    },
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.qr_code,
                    title: 'Activate New QR Sticker',
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => QRActive()));

                    },
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.shop,
                    title: 'My Orders/Products',
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => OrderHistoryScreen()));

                    },
                  ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.share,
                  //   title: 'Share Tap',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.account_balance_wallet,
                  //   title: 'Wallet',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.touch_app,
                  //   title: 'Active/Deactive QR',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.block,
                  //   title: 'Block A Number',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.bookmark,
                  //   title: 'My Story',
                  //   onTap: () {},
                  // ),
                  // _buildListTile(
                  //   context: context,
                  //   icon: Icons.call,
                  //   title: 'Call Log',
                  //   onTap: () {},
                  // ),
                  _buildListTile(
                    context: context,
                    icon: Icons.notifications,
                    title: 'Notification',
                    onTap: () {},
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.policy,
                    title: 'Terms & Policy',
                    onTap: () {},
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.description,
                    title: 'Grievances',
                    onTap: () {},
                  ),
                  _buildListTile(
                    context: context,
                    icon: Icons.bloodtype,
                    title: 'Blood Donation',
                    onTap: () {},
                  ),
              _buildListTile(
                context: context,
                icon: Icons.logout,
                title: 'Logout',
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear(); // ✅ Clear all stored data

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );

                },
              )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.sp,
            backgroundImage: const AssetImage('assets/playstore.png'),
            backgroundColor: AppColors.lightGray,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryBlue, width: 3.sp),
              ),
            ),
          ),
           SizedBox(height: 8.sp),
          Text(
            'Ravikant Saini',
            style: TextStyle(
              color: AppColors.navyBlue,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.sp),

        ],
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = AppColors.primaryBlue,
    Color iconColor = AppColors.primaryBlue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          // Add a splash color for a nice touch
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 12.sp,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color:  AppColors.navyBlue,
                  size: 24.sp,
                ),
                 SizedBox(width: 12.sp),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color:  AppColors.navyBlue,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}