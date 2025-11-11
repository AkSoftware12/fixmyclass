import 'dart:math';
import 'package:fixmyclass/Utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ------------------------------------------------------------
/// If you already have AppColors2 in your project, remove this.
/// ------------------------------------------------------------
class AppColors2 {
  static const navyBlue = Color(0xFF0F172A);
  static const royalBlue = Color(0xFF2563EB);
  static const sky = Color(0xFF38BDF8);
  static const mint = Color(0xFF10B981);
  static const pink = Color(0xFFEC4899);
  static const cardGrad1 = Color(0xFF101828);
  static const cardGrad2 = Color(0xFF0B1220);
  static const light = Color(0xFFF8FAFC);
}

/// ------------------------------------------------------------
/// PRACTICE SETS SCREEN
/// ------------------------------------------------------------
class PracticeSetsScreen extends StatefulWidget {
  const PracticeSetsScreen({super.key});

  @override
  State<PracticeSetsScreen> createState() => _PracticeSetsScreenState();
}

class _PracticeSetsScreenState extends State<PracticeSetsScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _search = TextEditingController();
  final List<String> categories = [
    'All',
    'NEET',
    'JEE',
    'SSC',
    'NDA',
    'UPSC',
    'Railway',
    'Banking',
  ];
  String selectedCat = 'All';
  bool grid = true;

  // Demo data (replace with API data)
  final List<Map<String, dynamic>> sets = [
    {
      'title': 'Physics Power Pack',
      'subtitle': 'NEET • Mechanics & Waves',
      'image':
      'https://i.ytimg.com/vi/R0NMLJGLTRY/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDHwWHmhav-xvGbqzUxd1uy7or-0A',
      'time': 30,
      'questions': 25,
      'marks': 100,
      'category': 'NEET',
      'progress': 0.35,
      'new': true,
    },
    {
      'title': 'Organic Marathon',
      'subtitle': 'JEE • Hydrocarbons',
      'image':
      'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?q=80&w=1200&auto=format&fit=crop',
      'time': 45,
      'questions': 40,
      'marks': 160,
      'category': 'JEE',
      'progress': 0.12,
      'new': false,
    },
    {
      'title': 'Reasoning Booster',
      'subtitle': 'SSC • Logical Sets',
      'image':
      'https://images.unsplash.com/photo-1504805572947-34fad45aed93?q=80&w=1200&auto=format&fit=crop',
      'time': 20,
      'questions': 20,
      'marks': 80,
      'category': 'SSC',
      'progress': 0.78,
      'new': true,
    },
    {
      'title': 'Polity Quick Rev',
      'subtitle': 'UPSC • Laxmikanth',
      'image':
      'https://images.unsplash.com/photo-1507842217343-583bb7270b66?q=80&w=1200&auto=format&fit=crop',
      'time': 25,
      'questions': 22,
      'marks': 88,
      'category': 'UPSC',
      'progress': 0.0,
      'new': false,
    },
    {
      'title': 'Maths Speed Drill',
      'subtitle': 'Railway • Arithmetic',
      'image':
      'https://www.smartkeeda.com/pdf/head_img/speed-mathematics.jpeg',
      'time': 35,
      'questions': 30,
      'marks': 120,
      'category': 'Railway',
      'progress': 0.55,
      'new': false,
    },
    {
      'title': 'Banking Awareness',
      'subtitle': 'Banking • Economy',
      'image':
      'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?q=80&w=1200&auto=format&fit=crop',
      'time': 30,
      'questions': 25,
      'marks': 100,
      'category': 'Banking',
      'progress': 0.9,
      'new': false,
    },
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filtered {
    final q = _search.text.trim().toLowerCase();
    return sets.where((e) {
      final okCat = selectedCat == 'All' || e['category'] == selectedCat;
      final okQ = q.isEmpty ||
          e['title'].toString().toLowerCase().contains(q) ||
          e['subtitle'].toString().toLowerCase().contains(q);
      return okCat && okQ;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // If not already using ScreenUtilInit in main, wrap this widget there.
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Practice Sets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor:AppColors.navyBlue,
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: GestureDetector(
              onTap: () => setState(() => grid = !grid),
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
                            color: grid ? Colors.white : Colors.black,
                            size: 20.sp,
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            Icons.view_list_rounded,
                            color: !grid ? Colors.white : Colors.black,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    AnimatedAlign(
                      alignment: grid
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
                          grid
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
      body: SafeArea(
        child: Column(
          children: [
            // ----------------- HEADER -----------------

            // ----------------- SEARCH -----------------
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SizedBox(
                height: 45.sp,
                child: _Glass(
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: Colors.white70),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          controller: _search,
                          onChanged: (_) => setState(() {}),
                          style: TextStyle(color: Colors.white, fontSize: 13.sp),
                          decoration: InputDecoration(
                            hintText: 'Search topics, chapters…',
                            hintStyle:
                            TextStyle(color: Colors.white70, fontSize: 12.5.sp),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (_search.text.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _search.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.close_rounded, color: Colors.white70),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // ----------------- CATEGORIES -----------------
            SizedBox(height: 10.h),
            SizedBox(
              height: 30.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  final c = categories[i];
                  final sel = c == selectedCat;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCat = c),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        gradient: sel
                            ? const LinearGradient(
                          colors: [AppColors2.mint, AppColors2.sky],
                        )
                            : const LinearGradient(
                          colors: [Color(0x22FFFFFF), Color(0x11FFFFFF)],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          width: 1,
                          color: sel ? Colors.transparent : Colors.white24,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            sel ? Icons.check_circle_rounded : Icons.circle,
                            size: 14.sp,
                            color: sel ? Colors.white : Colors.white54,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            c,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.5.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemCount: categories.length,
              ),
            ),

            // ----------------- LIST/GRID -----------------
            SizedBox(height: 8.h),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: filtered.isEmpty
                    ? Center(
                  child: Text(
                    'No practice sets found',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13.sp,
                    ),
                  ),
                )
                    : grid
                    ? _GridView(sets: filtered, onOpen: _openDetails)
                    : _ListView(sets: filtered, onOpen: _openDetails),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _DetailsSheetContainer(item: item),
    );
  }
}

/// ----------------- GLASS CONTAINER -----------------
class _Glass extends StatelessWidget {
  final Widget child;
  const _Glass({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white24, width: 1),
        boxShadow: const [
          BoxShadow(color: Colors.black38, blurRadius: 12, offset: Offset(0, 6))
        ],
      ),
      child: child,
    );
  }
}

/// ----------------- GRID VIEW -----------------
class _GridView extends StatelessWidget {
  final List<Map<String, dynamic>> sets;
  final void Function(Map<String, dynamic>) onOpen;

  const _GridView({required this.sets, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(10.w, 4.h, 10.w, 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (ScreenUtil().screenWidth > 480) ? 3 : 2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 0.85,
      ),
      itemCount: sets.length,
      itemBuilder: (_, i) => _PracticeCard(data: sets[i], onTap: onOpen),
    );
  }
}

/// ----------------- LIST VIEW -----------------
class _ListView extends StatelessWidget {
  final List<Map<String, dynamic>> sets;
  final void Function(Map<String, dynamic>) onOpen;

  const _ListView({required this.sets, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(10.w, 4.h, 10.w, 10.h),
      itemCount: sets.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (_, i) => _PracticeCard(
        data: sets[i],
        onTap: onOpen,
        listStyle: true,
      ),
    );
  }
}

/// ----------------- PRACTICE CARD -----------------
class _PracticeCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final void Function(Map<String, dynamic>) onTap;
  final bool listStyle;

  const _PracticeCard({
    required this.data,
    required this.onTap,
    this.listStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (data['progress'] as num).clamp(0, 1).toDouble();
    return GestureDetector(
      onTap: () => onTap(data),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: 1,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors2.cardGrad1, AppColors2.cardGrad2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.white12, width: 1),
            boxShadow: const [
              BoxShadow(color: Colors.black45, blurRadius: 16, offset: Offset(0, 8))
            ],
          ),
          child: listStyle ? _listLayout(progress) : _gridLayout(progress),
        ),
      ),
    );
  }

  Widget _badgeNew() => data['new'] == true
      ? Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: AppColors2.pink.withOpacity(0.9),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Text(
      'NEW',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 10.sp,
      ),
    ),
  )
      : const SizedBox.shrink();

  Widget _gridLayout(double progress) {
    return Column(
      children: [
        // image
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  data['image'],
                  fit: BoxFit.cover,
                  loadingBuilder: (c, w, ev) =>
                  ev == null ? w : const _ShimmerBox(),
                ),
              ),
              Positioned(
                left: 10.w,
                top: 10.h,
                child: _badgeNew(),
              ),
              Positioned(
                right: 10.w,
                bottom: 10.h,
                child: _timePill('${data['time']}m'),
              ),
            ],
          ),
        ),
        // content
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProgressRing(progress: progress, size: 36.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      data['subtitle'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(color: Colors.white70, fontSize: 11.5.sp),
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _chipMini(Icons.help_outline_rounded,
                '${data['questions']} Q'),
            SizedBox(width: 8.w),
            _chipMini(Icons.stars_rounded, '${data['marks']} M'),
            // const Spacer(),

          ],
        ),

      ],
    );
  }

  Widget _listLayout(double progress) {
    return Row(
      children: [
        // image
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            bottomLeft: Radius.circular(10.r),
          ),
          child: Stack(
            children: [
              Container(
                width: 120.w,
                height: 100.h,
                color: Colors.black12,
                child: Image.network(
                  data['image'],
                  fit: BoxFit.cover,
                  loadingBuilder: (c, w, ev) =>
                  ev == null ? w : const _ShimmerBox(),
                ),
              ),
              Positioned(left: 8.w, top: 8.h, child: _badgeNew()),
              Positioned(right: 8.w, bottom: 8.h, child: _timePill('${data['time']}m')),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  data['subtitle'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _chipMini(Icons.help_outline_rounded,
                        '${data['questions']} Q'),
                    SizedBox(width: 8.w),
                    _chipMini(Icons.stars_rounded, '${data['marks']} M'),
                    const Spacer(),
                    _ProgressRing(progress: progress, size: 34.sp),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _chipMini(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12.sp, color: Colors.white70),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  Widget _timePill(String t) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule_rounded, color: Colors.white, size: 12),
          SizedBox(width: 4.w),
          Text(t, style: TextStyle(color: Colors.white, fontSize: 10.5.sp)),
        ],
      ),
    );
  }
}


class _DetailsSheetContainer extends StatelessWidget {
  final Map<String, dynamic> item;
  const _DetailsSheetContainer({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 30.h,
        left: 0,
        right: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors2.navyBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          border: Border.all(color: Colors.white12),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: _DetailsContent(item: item),
          ),
        ),
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  final Map<String, dynamic> item;
  const _DetailsContent({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Center(
          child: Container(
            width: 46.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(item['image'], fit: BoxFit.cover),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors2.royalBlue, AppColors2.sky],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule_rounded,
                        size: 14, color: Colors.white),
                    SizedBox(width: 6.w),
                    Text(
                      '${item['time']} min',
                      style: TextStyle(color: Colors.white, fontSize: 12.5.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            item['subtitle'],
            style: TextStyle(color: Colors.white70, fontSize: 13.5.sp),
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _infoTile(Icons.help_outline_rounded,
                  '${item['questions']} Questions'),
              SizedBox(width: 10.w),
              _infoTile(Icons.stars_rounded, '${item['marks']} Marks'),
              SizedBox(width: 10.w),
              _infoTile(Icons.category_rounded, item['category']),
            ],
          ),
        ),
        SizedBox(height: 18.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: _Glass(
            child: Row(
              children: [
                const Icon(Icons.auto_graph_rounded, color: Colors.white70),
                SizedBox(width: 8.w),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: LinearProgressIndicator(
                      value: (item['progress'] as num).clamp(0, 1).toDouble(),
                      minHeight: 8.h,
                      backgroundColor: Colors.white12,
                      valueColor:
                      const AlwaysStoppedAnimation(AppColors2.mint),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  '${(((item['progress'] as num).toDouble()) * 100).round()}%',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors2.mint,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Start Practice tapped')),
                );
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(
                'Start Practice',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 14.sp),
          SizedBox(width: 6.w),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 12.5.sp)),
        ],
      ),
    );
  }
}

/// ----------------- PROGRESS RING -----------------
class _ProgressRing extends StatelessWidget {
  final double progress; // 0..1
  final double size;
  const _ProgressRing({required this.progress, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, height: size,
      child: CustomPaint(
        painter: _RingPainter(progress),
        child: Center(
          child: Text(
            '${(progress * 100).round()}%',
            style: TextStyle(
              color: Colors.white,
              fontSize: max(8, size * 0.28),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double p;
  _RingPainter(this.p);

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round;

    final prog = Paint()
      ..shader = const SweepGradient(
        colors: [AppColors2.mint, AppColors2.sky, AppColors2.royalBlue],
      ).createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width/2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width/2, size.height/2);
    final radius = size.width/2;

    // base circle
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -pi/2, 2*pi, false, base);

    // progress arc
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -pi/2, 2*pi*p.clamp(0, 1), false, prog);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => oldDelegate.p != p;
}

/// ----------------- SHIMMER (simple) -----------------
class _ShimmerBox extends StatefulWidget {
  const _ShimmerBox();

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white10,
                Colors.white24,
                Colors.white10,
              ],
              stops: [
                (_c.value - 0.3).clamp(0, 1),
                _c.value,
                (_c.value + 0.3).clamp(0, 1),
              ].map((e) => e.toDouble()).toList(),
            ),
          ),
        );
      },
    );
  }
}
