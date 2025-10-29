import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../../Utils/color.dart';

class WeeklyReportScreen extends StatefulWidget {
  const WeeklyReportScreen({super.key});

  @override
  State<WeeklyReportScreen> createState() => _WeeklyReportScreenState();
}

class _WeeklyReportScreenState extends State<WeeklyReportScreen> {
  bool isGridView = true;

  final List<Map<String, dynamic>> reports = [
    {
      'title': 'Watch Video',
      'icon': Icons.play_circle_fill_rounded,
      'progress': 0.75,
      'completed': 15,
      'total': 20,
    },
    {
      'title': 'Revise Notes',
      'icon': Icons.menu_book_rounded,
      'progress': 0.45,
      'completed': 9,
      'total': 20,
    },
    {
      'title': 'Quiz',
      'icon': Icons.quiz_rounded,
      'progress': 0.20,
      'completed': 4,
      'total': 20,
    },
    {
      'title': 'Practice Questions',
      'icon': Icons.question_answer_rounded,
      'progress': 0.90,
      'completed': 18,
      'total': 20,
    },
  ];

  // ✅ Function to determine color based on progress
  Color getProgressColor(double progress) {
    if (progress < 0.3) return Colors.red;
    if (progress < 0.6) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Weekly Report',
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.grid_view_rounded,
                            color: isGridView ? Colors.white : Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.view_list_rounded,
                            color: !isGridView ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    AnimatedAlign(
                      alignment: isGridView
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
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
                          size: 18.sp,
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
        padding: EdgeInsets.all(12.sp),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isGridView ? _buildGridView() : _buildListView(),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: reports.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final item = reports[index];
        return _buildReportCard(item, true);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final item = reports[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: _buildReportCard(item, false),
        );
      },
    );
  }

  Widget _buildReportCard(Map<String, dynamic> item, bool isGrid) {
    final color = getProgressColor(item['progress']); // 🎨 dynamic color

    if (isGrid) {
      // 🟩 GRID VIEW (same as before)
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 42.r,
              lineWidth: 7.w,
              percent: item['progress'],
              backgroundColor: Colors.grey.shade200,
              progressColor: color,
              circularStrokeCap: CircularStrokeCap.round,
              center: Icon(item['icon'], color: color, size: 30.sp),
              animation: true,
              animationDuration: 800,
            ),
            SizedBox(height: 12.h),
            Text(
              item['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              '${(item['progress'] * 100).toInt()}% Completed',
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    } else {
      // 🟦 LIST VIEW (updated with LinearPercentIndicator)
      return Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(item['icon'], color: color, size: 28.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // 🧭 Linear Percent Indicator
                  LinearPercentIndicator(
                    animation: true,
                    lineHeight: 8.h,
                    barRadius: Radius.circular(10.r),
                    percent: item['progress'],
                    backgroundColor: Colors.grey.shade300,
                    progressColor: color,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Completed: ${item['completed']} / ${item['total']}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        '${(item['progress'] * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
