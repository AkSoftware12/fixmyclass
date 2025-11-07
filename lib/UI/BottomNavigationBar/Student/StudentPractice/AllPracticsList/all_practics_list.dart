import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../student_practice.dart';

class AllPracticsList extends StatefulWidget {
  const AllPracticsList({super.key});

  @override
  State<AllPracticsList> createState() => _AllPracticsListState();
}

class _AllPracticsListState extends State<AllPracticsList>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> item = [
    {
      'title': 'NEET',
      'subtitle': 'Medical Entrance',
      'image':
      'https://img.freepik.com/free-photo/doctor-stethoscope-healthcare-medical-concept_1150-15051.jpg',
    },
    {
      'title': 'JEE',
      'subtitle': 'Engineering Entrance',
      'image':
      'https://img.freepik.com/free-photo/engineer-meeting_53876-119169.jpg',
    },
    {
      'title': 'SSC',
      'subtitle': 'Staff Selection Exam',
      'image':
      'https://img.freepik.com/free-photo/businessman-reading-documents-office_23-2147830558.jpg',
    },
    {
      'title': 'UP Police',
      'subtitle': 'Police Recruitment',
      'image':
      'https://img.freepik.com/free-photo/police-officer-posing-street_23-2147830089.jpg',
    },
    {
      'title': 'ARMY',
      'subtitle': 'Defence Exam',
      'image':
      'https://img.freepik.com/free-photo/soldiers-training-ground_23-2147726945.jpg',
    },
    {
      'title': 'NDA',
      'subtitle': 'National Defence Academy',
      'image':
      'https://img.freepik.com/free-photo/soldier-standing-military-uniform_23-2147651871.jpg',
    },
    {
      'title': 'UPSC',
      'subtitle': 'Civil Services Exam',
      'image':
      'https://img.freepik.com/free-photo/business-meeting-office_23-2147830573.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f6ff),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        itemCount: item.length,
        itemBuilder: (context, index) {
          final items = item[index];
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 500 + (index * 120)),
            tween: Tween<double>(begin: 0, end: 1),
            curve: Curves.easeOutBack,
            builder: (context, double value, child) {
              final safeValue = value.clamp(0.0, 1.0); // 👈 clamp ensures safe range
              return Opacity(
                opacity: safeValue,
                child: Transform.translate(
                  offset: Offset(0, (1 - safeValue) * 50),
                  child: child,
                ),
              );
            },
            child: _buildListCard(items),
          );

        },
      ),
    );
  }

  Widget _buildListCard(Map<String, dynamic> items) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xffe9f1ff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey, width: 1.sp),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PracticeScreen(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 📷 Image
              Container(
                height: 75.sp,
                width: 75.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 1.sp,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    items['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              // 📝 Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items['title'],
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      items['subtitle'],
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        _infoChip(Icons.play_circle_fill, 'Start Practice',
                            Colors.blue),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                color: Colors.black45,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: 3.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
