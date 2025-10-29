import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixmyclass/UI/BottomNavigationBar/Student/SeeAll/AllCourse/all_course_screen.dart';
import 'package:fixmyclass/UI/BottomNavigationBar/Student/SeeAll/RecommendedForYou/recommended_screen.dart';
import 'package:fixmyclass/Utils/HexColorCode/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utils/color.dart';
import '../SeeAll/DailyGoals/daily_goals_screen.dart';
import '../WeeklyProgressReport/weekly_report_screen.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage>
    with TickerProviderStateMixin {
  late PageController _pageController;

  final List<String> _images = [
    "https://www.edushastra.com/wp-content/uploads/2025/07/CAT_inner_page_Banner.webp",
    "https://nationdefenceacademy.com/images/nda/nda-banner.jpg",
    "https://www.iquanta.in/blog/wp-content/uploads/2024/04/WhatsApp-Image-2024-04-12-at-3.52.13-PM-1.jpeg",
    "https://skilledb.com/wp-content/uploads/2025/03/01-banner.jpg",
    "https://dcx0p3on5z8dw.cloudfront.net/Aakash/importantconcepts/2023/Dec/IACST%20Scholarship%20Banner%202.jpg?",
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // 🔁 Auto-slide
    Future.delayed(const Duration(seconds: 4), _autoSlide);
  }

  void _autoSlide() {
    if (!mounted) return;
    int nextPage = (_currentIndex + 1) % _images.length;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
    setState(() => _currentIndex = nextPage);
    Future.delayed(const Duration(seconds: 4), _autoSlide);
  }


  Widget _buildBannerSlider() {
    return Column(
      children: [
        SizedBox(height: 3.h),
        CarouselSlider.builder(
          itemCount: _images.length,
          options: CarouselOptions(
            height: 140.h,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: 5.seconds,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      _images[index],
                      fit: BoxFit.fill,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child; // Image is already loaded
                        }
                        return frame != null
                            ? child // Image loaded successfully
                            : const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(
                                Color(0xFFBBDEFB)), // Colors.blue[200]
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.broken_image,
                        size: 40.sp,
                        // Assuming you're using a package like flutter_screenutil for .sp
                        color: Colors.grey[300],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 15.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _images.length,
                (index) => AnimatedContainer(
              duration: 300.ms,
              width: _currentIndex == index ? 15.w : 8.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: _currentIndex == index
                    ? Colors.blue[800]
                    : Colors.grey[400],
              ),
            ),
          ),
        ),
        SizedBox(height: 15.sp),

      ],
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> entranceExams = [
    {
      'exam': 'JEE',
      'fullForm': 'Joint Entrance Examination',
      'field': 'Engineering',
      'image':
          'https://server-api.aaaedu.in/storage/blogs/FYpD5OXkOu6AubFTm085pAq79bESOHBdneOaYUcU.webp',
      // 🧮
    },
    {
      'exam': 'NEET',
      'fullForm': 'National Eligibility cum Entrance Test',
      'field': 'Medical',
      'image':
          'https://abhyaasgkp.com/wp-content/uploads/2025/04/Abhyaas-classes-home-page-banner-gorakhpur-3-scaled.jpg',
      // 🩺
    },
    {
      'exam': 'CLAT',
      'fullForm': 'Common Law Admission Test',
      'field': 'Law',
      'image':
          'https://www.brainwonders.in/blog_feature_images/2023/01/2023-01-21-12-22-07CLAT_Full_form,_Eligibility_Criteria_2024,_Age_Limit,_Qualification,_Minimum_Qualifying_Marks.png',
      // ⚖️
    },
    {
      'exam': 'NDA',
      'fullForm': 'National Defence Academy',
      'field': 'Defence Services',
      'image':
          'https://www.studyiq.com/articles/wp-content/uploads/2023/10/30154734/NDA-Exam.jpg',
      // 🪖
    },
    {
      'exam': 'UPSC',
      'fullForm': 'Union Public Service Commission',
      'field': 'Civil Services',
      'image':
          'https://www.careerpower.in/blog/wp-content/uploads/2025/04/22125407/UPSC-Civil-Service-Result-2024.webp',
      // 🏛️
    },
    {
      'exam': 'SSC',
      'fullForm': 'Staff Selection Commission',
      'field': 'Government Jobs',
      'image':
          'https://udyogmitrabihar.in/wp-content/uploads/2024/06/SSC-Exams-2024-Everything-You-Need-To-Know.jpg',
      // 💼
    },
    {
      'exam': 'CUCET / CUET',
      'fullForm': 'Central Universities Common Entrance Test',
      'field': 'Central University Admissions',
      'image':
          'https://i.ytimg.com/vi/NdmZ7kV9JFk/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDZ3xotD96MOeHRgMlf1Sq1hp_uAQ',
      // 📊
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        MediaQuery.of(context).padding.bottom +
        MediaQuery.of(context).viewInsets.bottom +
        20.0;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240.sp,
            backgroundColor:  Colors.white,
            iconTheme: IconThemeData(color: AppColors.navyBlue),
            floating: false,
            pinned: true, // ✅ keeps search bar visible on scroll
            automaticallyImplyLeading: false,
            title:TextField(
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                suffixIcon: Icon(Icons.mic_rounded, color: Colors.grey.shade600, size: 22.sp),
                filled: true,
                fillColor: Colors.white.withOpacity(0.9),

                // ✅ 1.sp border with rounded corners
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1.sp),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide(color: Colors.grey, width: 1.sp),
                ),

                contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              ),
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              onChanged: (value) {
                // Search logic
              },
            ),


        flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [

                  // 🖼 Banner on top
                  Container(
                    color: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Container(
                          height: 60.sp,
                        ),
                        _buildBannerSlider(),
                      ],
                    ),
                  ),



                  // 🔍 Search bar at bottom

                ],
              ),
            ),
          ),




          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🏁 Title with gradient accent
                  Row(
                    children: [
                      Container(
                        width: 5.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade800,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Daily Goals',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade900,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),

                  // ➕ Add Goal button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DailyGoalScreen(),
                        ),
                      );

                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    // icon: Icon(
                    //   Icons.add_circle_outline,
                    //   size: 18.sp,
                    //   color: Colors.blue.shade700,
                    // ),
                    label: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100.sp,
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildAnimatedGoalCard(
                    'Complete Math Quiz',
                    Icons.quiz_rounded,
                    AppColors.bottomRed,
                    true,
                    0.2,
                  ),
                  SizedBox(width: 12.w),
                  _buildAnimatedGoalCard(
                    'Watch Physics Video',
                    Icons.play_circle_fill_rounded,
                    Colors.pink,
                    false,
                    0.4,
                  ),
                  SizedBox(width: 12.w),
                  _buildAnimatedGoalCard(
                    'Revise Biology Notes',
                    Icons.menu_book_rounded,
                    Colors.purpleAccent,
                    false,
                    0.6,
                  ),
                  SizedBox(width: 12.w),
                  _buildAnimatedGoalCard(
                    'Practice Coding',
                    Icons.code_rounded,
                    Colors.red,
                    false,
                    0.8,
                  ),
                ],
              ),
            ),
          ),
          // Premium Progress with Circular Indicator
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  WeeklyReportScreen(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 🌀 Circular Progress Ring
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 64.w,
                            height: 64.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.greenAccent.shade400,
                                  Colors.teal.shade400,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 54.w,
                            height: 54.w,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 0.75),
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.easeInOutCubic,
                              builder: (context, value, _) =>
                                  CircularProgressIndicator(
                                    value: value,
                                    strokeWidth: 5,
                                    backgroundColor: Colors.white.withOpacity(
                                      0.2,
                                    ),
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  ),
                            ),
                          ),
                          Text(
                            "75%",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 18.w),

                      // 📊 Progress Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weekly Progress',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade900,
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 0.75),
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, _) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${(value * 100).toInt()}% complete • 3/4 goals achieved',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: LinearProgressIndicator(
                                        value: value,
                                        minHeight: 8.h,
                                        backgroundColor: Colors.grey.shade200.withOpacity(0.6),
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.greenAccent.shade400,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Premium Recommended Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 20.sp),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 5.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade300),

                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.class_,
                        color: Colors.blue.shade700,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    Expanded(
                      child: Text(
                        'Course',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade900,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  AllCoursesScreen(appBar: '',),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      // icon: Icon(
                      //   Icons.add_circle_outline,
                      //   size: 18.sp,
                      //   color: Colors.blue.shade700,
                      // ),
                      label: Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.sp),

                // 👉 Recommended cards list
                SizedBox(
                  height: 150.sp,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: entranceExams.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 180.sp,
                        margin: EdgeInsets.only(right: 0, left: 8.sp),
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    entranceExams[index]['image'].toString(),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              entranceExams[index]['exam'].toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade900,
                                letterSpacing: -0.2,
                              ),
                            ),
                            Text(
                              entranceExams[index]['fullForm'].toString(),
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Premium GridView with Glassmorphism Cards
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 20.sp),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 5.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade300),

                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.recommend_rounded,
                        color: Colors.blue.shade700,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    Expanded(
                      child: Text(
                        'Recommended For You',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade900,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  RecommendedForYouScreen(title: 'Recommended For You',),
                          ),
                        );
                      },

                      label: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.blue.shade700,
                        size: 16.sp,
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue.shade700,
                        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75, // better height balance
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return _buildPremiumCourseCard(index);
                },
                childCount: 6,
              ),
            ),
          ),
          // Bottom padding
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 20.sp),
          //     child: LatestNewsSection()
          //   ),
          // ),
          LatestNewsSection(),

          SliverToBoxAdapter(child: SizedBox(height: bottomPadding)),
        ],
      ),
      // Premium FAB with Speed Dial
    );
  }

  Widget _buildAnimatedGoalCard(
    String title,
    IconData icon,
    Color color,
    bool completed,
    double progress,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      width: 150.sp,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: color.withOpacity(0.4),
        //     blurRadius: 10,
        //     offset: const Offset(0, 5),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5.sp),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 15.sp),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: completed
                      ? Colors.white.withOpacity(0.25)
                      : Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                child: Text(
                  completed ? 'Done' : 'Active',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.sp),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade100,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 5.sp),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4.sp,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildPremiumCourseCard(int index) {
    final List<String> images = [
      'https://i.pinimg.com/736x/09/c9/73/09c97322a47b7acb63570ef8f370b303.jpg',
      'https://www.vedantu.store/cdn/shop/files/NEET_CRASH.png?v=1754988229&width=1445',
      'https://clat-uploads.s3.amazonaws.com/blog/7b582841-958d-4c09-b81d-a8a2993581b1.29',
      'https://i.pinimg.com/736x/44/7b/34/447b34e9ab5bf3c356ea150fb4271572.jpg',
      'https://i.pinimg.com/736x/bd/46/9b/bd469b2262f6ca89816353cb876ce1eb.jpg',
      'https://m.media-amazon.com/images/I/81pws0wrC-L._AC_UF1000,1000_QL80_.jpg',
    ];

    final List<String> titles = [
      'JEE Preparation',
      'NEET Crash Course',
      'CLAT Law Mastery',
      'NDA Defence Prep',
      'Hotel Management',
      'CAT MBA Booster',
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // ✅ prevents forced expansion
        children: [
          // 🖼 Course Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp)),
            child: CachedNetworkImage(
              imageUrl: images[index % images.length] ?? '',
              height: 155.sp,
              width: double.infinity,
              fit: BoxFit.cover,
              // 🌀 Show shimmer-like loading
              placeholder: (context, url) => Container(
                color: Colors.grey.shade300,
              ),
              // 🖼 Show default image if URL is null or error
              errorWidget: (context, url, error) => Image.asset(
                'assets/noimg.jpg',
                height: 155.sp,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 📘 Course Details
          Flexible( // ✅ ensures content fits in remaining height
            child: Padding(
              padding: EdgeInsets.all(6.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[index % titles.length],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  SizedBox(height: 3.sp),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '4.${index + 3} ★',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '₹${999 + index * 100}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.sp),

                  SizedBox(
                    width: double.infinity,
                    height: 28.sp,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Enroll Now',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}





class LatestNewsSection extends StatefulWidget {
  const LatestNewsSection({super.key});

  @override
  State<LatestNewsSection> createState() => _LatestNewsSectionState();
}

class _LatestNewsSectionState extends State<LatestNewsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _currentIndex = 0;

  final List<Map<String, String>> _newsList = [
    {
      "image":
      "https://thestudybuzz.com/wp-content/uploads/2024/05/Study-buzz-Blog-banner-14-1024x576.png",
      "title": "JEE 2025 Registration Opens: Check Important Dates & Tips"
    },
    {
      "image":
      "https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849826_1280.jpg",
      "title": "Top 10 Law Colleges in India as per 2025 Rankings"
    },
    {
      "image":
      "https://thestudybuzz.com/wp-content/uploads/2024/05/Study-buzz-Blog-banner-14-1024x576.png",
      "title": "NEET Exam 2025: New Syllabus Announced for Students"
    },

    {
      "image":
      "https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849826_1280.jpg",
      "title": "Top 10 Law Colleges in India as per 2025 Rankings"
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 4), () {
      if (_pageController.hasClients && mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _newsList.length;
        });
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        _startAutoSlide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📰 Header bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.newspaper_rounded,
                      color: Colors.blue.shade700,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.sp),
                  Expanded(
                    child: Text(
                      'Latest News',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade900,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.blue.shade700,
                      size: 16.sp,
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue.shade700,
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.sp, vertical: 4.sp),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.sp),

            // 🖼️ Horizontal image slider
            SizedBox(
              height: 160.sp,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _newsList.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final news = _newsList[index];
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.2)).clamp(0.9, 1.0);
                      }
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: news["image"]!,
                              fit: BoxFit.cover,
                              fadeInDuration:
                              const Duration(milliseconds: 500),
                              placeholder: (context, url) => Container(
                                color: Colors.grey.shade300,
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                            // Gradient + title overlay
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black54,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 12,
                              right: 12,
                              child: Text(
                                news["title"]!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
