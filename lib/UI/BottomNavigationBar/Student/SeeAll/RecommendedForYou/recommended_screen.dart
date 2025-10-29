import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utils/color.dart';

class RecommendedForYouScreen extends StatefulWidget {
  final String title;
  const RecommendedForYouScreen({super.key, required this.title});

  @override
  State<RecommendedForYouScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<RecommendedForYouScreen> {
  bool isGridView = true; // ✅ default: grid view

  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        MediaQuery.of(context).padding.bottom +
            MediaQuery.of(context).viewInsets.bottom +
            20.sp;
    return Scaffold(
      backgroundColor:  AppColors.navyBlue,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title:  Text(widget.title,style: TextStyle(
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

      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            sliver: isGridView ? _buildGridView() : _buildListView(),
          ),
          SliverToBoxAdapter(child: SizedBox(height: bottomPadding)),

        ],
      ),
    );
  }

  /// 🧩 GRID VIEW
  Widget _buildGridView() {
    return SliverGrid(
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
        childCount: 12,
      ),
    );
  }

  /// 📋 LIST VIEW (horizontal-style cards)
  Widget _buildListView() {
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

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl: images[index % images.length],
                    width: 110.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey.shade300),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/noimg.jpg',
                      width: 110.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),

                // 📘 Text Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index % titles.length],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4.w),
                          Text(
                            '4.${index + 3} ★',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Text(
                            '₹${999 + index * 100}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 28.sp,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                              ),
                              child: Text(
                                'Enroll',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
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
        },
        childCount: 12,
      ),
    );
  }


  /// 🧱 COMMON CARD
  Widget _buildPremiumCourseCard(int index) {
    final List<String> images = [
      'https://i.pinimg.com/736x/09/c9/73/09c97322a47b7acb63570ef8f370b303.jpg',
      'https://www.vedantu.store/cdn/shop/files/NEET_CRASH.png?v=1754988229&width=1445',
      'https://clat-uploads.s3.amazonaws.com/blog/7b582841-958d-4c09-b81d-a8a2993581b1.29',
      'https://i.pinimg.com/736x/44/7b/34/447b34e9ab5bf3c356ea150fb4271572.jpg',
      'https://i.pinimg.com/736x/bd/46/9b/bd469b2262f6ca89816353cb876ce1eb.jpg',
      'https://m.media-amazon.com/images/I/81pws0wrC-L._AC_UF1000,1000_QL80_.jpg',
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

