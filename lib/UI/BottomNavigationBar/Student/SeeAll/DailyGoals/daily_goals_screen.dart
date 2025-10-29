import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Utils/color.dart';

class DailyGoalScreen extends StatefulWidget {
  const DailyGoalScreen({super.key});

  @override
  State<DailyGoalScreen> createState() => _DailyGoalScreenState();
}

class _DailyGoalScreenState extends State<DailyGoalScreen> {
  bool isGridView = true; // 🔹 default GridView on load

  final List<Map<String, dynamic>> goals = [
    {
      'title': 'Complete Math Quiz',
      'icon': Icons.quiz_rounded,
      'color': Colors.green,
      'completed': true,
      'progress': 0.2,
    },
    {
      'title': 'Watch Physics Video',
      'icon': Icons.play_circle_fill_rounded,
      'color': Colors.pink,
      'completed': false,
      'progress': 0.4,
    },
    {
      'title': 'Revise Biology Notes',
      'icon': Icons.menu_book_rounded,
      'color': Colors.purpleAccent,
      'completed': false,
      'progress': 0.6,
    },
    {
      'title': 'Practice Coding',
      'icon': Icons.code_rounded,
      'color': Colors.red,
      'completed': false,
      'progress': 0.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        MediaQuery.of(context).padding.bottom +
            MediaQuery.of(context).viewInsets.bottom +
            20.sp;
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title:  Text('Daily Goals',style: TextStyle(
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
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: isGridView
              ? _buildGridView()
              : _buildListView(),
        ),
      ),
    );
  }

  // 🔹 GRID VIEW
  Widget _buildGridView() {
    return GridView.builder(
      key: const ValueKey('grid'),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 120.sp,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final g = goals[index];
        return _buildAnimatedGoalCard(
          g['title'],
          g['icon'],
          g['color'],
          g['completed'],
          g['progress'],
        );
      },
    );
  }

  // 🔹 LIST VIEW
  Widget _buildListView() {
    return ListView.separated(
      key: const ValueKey('list'),
      physics: const BouncingScrollPhysics(),
      itemCount: goals.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final g = goals[index];
        return _buildAnimatedGoalCard(
          g['title'],
          g['icon'],
          g['color'],
          g['completed'],
          g['progress'],
        );
      },
    );
  }

  // 🎯 Goal Card Widget
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
      width: double.infinity,
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔸 Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(6.sp),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 18.sp),
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
          SizedBox(height: 18.sp),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade100,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 6.sp),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5.sp,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
