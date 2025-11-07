import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Utils/color.dart';
import '../student_quiz.dart';

class AllQuizList extends StatefulWidget {
  const AllQuizList({super.key});

  @override
  State<AllQuizList> createState() => _AllQuizListState();
}

class _AllQuizListState extends State<AllQuizList> {
  bool isGridView = false;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> item = [
    {
      'title': 'Quiz 11',
      'subtitle': 'Medical Entrance',
      'image':
      'https://img.freepik.com/free-photo/doctor-stethoscope-healthcare-medical-concept_1150-15051.jpg',
      'time': '30 min',
      'questions': 50,
      'marks': 200,
    },
    {
      'title': 'Quiz 12',
      'subtitle': 'Engineering Entrance',
      'image':
      'https://img.freepik.com/free-photo/engineer-meeting_53876-119169.jpg',
      'time': '45 min',
      'questions': 60,
      'marks': 240,
    },
    {
      'title': 'Quiz 13',
      'subtitle': 'Staff Selection Exam',
      'image':
      'https://img.freepik.com/free-photo/businessman-reading-documents-office_23-2147830558.jpg',
      'time': '40 min',
      'questions': 40,
      'marks': 160,
    },
    {
      'title': 'Quiz 14',
      'subtitle': 'Police Recruitment',
      'image':
      'https://img.freepik.com/free-photo/police-officer-posing-street_23-2147830089.jpg',
      'time': '25 min',
      'questions': 30,
      'marks': 120,
    },
    {
      'title': 'Quiz 15',
      'subtitle': 'Defence Exam',
      'image':
      'https://img.freepik.com/free-photo/soldiers-training-ground_23-2147726945.jpg',
      'time': '35 min',
      'questions': 45,
      'marks': 180,
    },
    {
      'title': 'Quiz 16',
      'subtitle': 'National Defence Academy',
      'image':
      'https://img.freepik.com/free-photo/soldier-standing-military-uniform_23-2147651871.jpg',
      'time': '50 min',
      'questions': 80,
      'marks': 320,
    },
    {
      'title': 'Quiz 17',
      'subtitle': 'Civil Services Exam',
      'image':
      'https://img.freepik.com/free-photo/business-meeting-office_23-2147830573.jpg',
      'time': '60 min',
      'questions': 100,
      'marks': 400,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = item
        .where((quiz) =>
    quiz['title']
        .toString()
        .toLowerCase()
        .contains(searchQuery.toLowerCase()) ||
        quiz['subtitle']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'All Quiz',
          style: TextStyle(
            color: AppColors.navyBlue,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.white,
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
                            size: 20.sp,
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.view_list_rounded,
                            color: !isGridView ? Colors.white : Colors.black,
                            size: 20.sp,
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
      body: Column(
        children: [
          // 🔍 Stylish Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff2f6ff),
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                style: TextStyle(fontSize: 14.sp),
                decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      setState(() {
                        searchQuery = '';
                      });
                    },
                    child: const Icon(Icons.close),
                  )
                      : null,
                  hintText: "Search Quiz...",
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
              ),
            ),
          ),

          // 📋 Quiz List / Grid
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
              child: Text(
                "No quizzes found 😔",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500),
              ),
            )
                : isGridView
                ? _buildGridView(filteredItems)
                : _buildListView(filteredItems),
          ),
        ],
      ),
    );
  }

  // 🔹 Small Info Chip Widget
  Widget _infoChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13.sp, color: color),
          SizedBox(width: 3.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> list) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final items = list[index];
        return Container(
          margin: EdgeInsets.only(bottom: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xffe9f1ff)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.grey.shade300, width: 1.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizPracticeScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(
                      items['image'],
                      height: 75.sp,
                      width: 75.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items['title'],
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87)),
                        SizedBox(height: 3.h),
                        Text(items['subtitle'],
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            _infoChip(Icons.timer, items['time'], Colors.blue),
                            SizedBox(width: 6.w),
                            _infoChip(CupertinoIcons.question_circle,
                                "${items['questions']} Qs", Colors.green),
                            SizedBox(width: 6.w),
                            _infoChip(CupertinoIcons.chart_bar_square,
                                "${items['marks']} Marks", Colors.orange),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(CupertinoIcons.chevron_right,
                      color: Colors.black45, size: 22),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> list) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.87,
      ),
      itemBuilder: (context, index) {
        final items = list[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xffe9f1ff)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.grey.shade300, width: 1.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizPracticeScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(6.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(
                      items['image'],
                      height: 100.sp,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(items['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87)),
                  Text(items['subtitle'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoChip(Icons.timer, items['time'], Colors.blue),
                      _infoChip(CupertinoIcons.question_circle,
                          "${items['questions']} Qs", Colors.green),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  _infoChip(CupertinoIcons.chart_bar_square,
                      "${items['marks']} Marks", Colors.orange),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
