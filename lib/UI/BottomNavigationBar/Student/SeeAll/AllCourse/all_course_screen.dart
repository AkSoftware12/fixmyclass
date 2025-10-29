import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utils/color.dart';

class AllCoursesScreen extends StatefulWidget {
  final String appBar;
  const AllCoursesScreen({super.key, required this.appBar});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  bool isGridView = true; // ✅ default: grid view

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  AppColors.navyBlue,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title:  Text('All Courses',style: TextStyle(
            color: Colors.white,fontSize: 15.sp
        ),),
        backgroundColor: AppColors.navyBlue,
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: GestureDetector(
              onTap: () => setState(() => isGridView = !isGridView),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 90.w,
                height: 36.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // --- Icons (both always visible) ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.grid_view_rounded,
                            color: isGridView ? Colors.white : Colors.black,
                            size: isGridView ? 22.sp : 20.sp,
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.view_list_rounded,
                            color: !isGridView ? Colors.white : Colors.black,
                            size: !isGridView ? 22.sp : 22.sp,
                          ),
                        ),
                      ],
                    ),

                    // --- Sliding knob animation ---
                    AnimatedAlign(
                      alignment:
                      isGridView ? Alignment.centerLeft : Alignment.centerRight,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        width: 38.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.navyBlue,
                          borderRadius: BorderRadius.circular(25.r),

                        ),
                        child: Icon(
                          isGridView
                              ? Icons.grid_view_rounded
                              : Icons.view_list_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],

      ),

      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: isGridView ? _buildGridView() : _buildListView(),
      ),
    );
  }

  /// 🧩 GRID VIEW
  Widget _buildGridView() {
    return GridView.builder(
      itemCount: entranceExams.length,
     padding:EdgeInsets.only(bottom: 40.sp),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final exam = entranceExams[index];
        return Padding(
          padding:  EdgeInsets.only(top: 10.sp),
          child: _buildExamCard(exam),
        );
      },
    );
  }

  /// 📋 LIST VIEW (vertical - premium look)
  Widget _buildListView() {
    return ListView.builder(
      itemCount: entranceExams.length,
      padding: EdgeInsets.only(bottom: 40.sp, top: 10.sp),
      // physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final exam = entranceExams[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 14.h),
          child: _buildListExamCard(exam),
        );
      },
    );
  }

  /// 🧱 COMMON CARD
  Widget _buildExamCard(Map<String, String> exam) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.sp),
        border: Border.all(color: Colors.white),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Image Section
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp)),
            child: Image.network(
              exam['image'] ?? '',
              height: 140.sp,
              width: double.infinity,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 120.sp,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 120.sp,
                color: Colors.grey.shade200,
                child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
              ),
            ),
          ),

          // ✅ Text Section
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exam['exam'] ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  exam['fullForm'] ?? '',
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /// 💎 Beautiful ListView Card
  Widget _buildListExamCard(Map<String, String> exam) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.15), Colors.white.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 🖼 Image Section
          Padding(
            padding:  EdgeInsets.all(8.r),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              child: Image.network(
                exam['image'] ?? '',
                height: 95.h,
                width: 110.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 95.h,
                  width: 110.w,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, color: Colors.grey, size: 30),
                ),
              ),
            ),
          ),

          // 📘 Details Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam['exam'] ?? '',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    exam['fullForm'] ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade200,
                      height: 1.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  // 🎯 Small Tag
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Text(
                      exam['field'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ➡ Arrow icon
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 18.sp),
          ),
        ],
      ),
    );
  }
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
