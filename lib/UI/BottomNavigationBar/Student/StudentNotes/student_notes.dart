import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utils/color.dart';

/// ------------------------------------------------------------
/// If you already have AppColors3, keep yours and remove this.
/// ------------------------------------------------------------
class AppColors3 {
  static const navyBlue = Color(0xFF0F172A);
  static const royalBlue = Color(0xFF2563EB);
  static const sky = Color(0xFF38BDF8);
  static const mint = Color(0xFF10B981);
  static const pink = Color(0xFFEC4899);
  static const cardGrad1 = Color(0xFF101828);
  static const cardGrad2 = Color(0xFF0B1220);
}

/// ============================================================
/// NOTES & STUDY MATERIALS SCREEN
/// ============================================================
class NotesMaterialsScreen extends StatefulWidget {
  const NotesMaterialsScreen({super.key});

  @override
  State<NotesMaterialsScreen> createState() => _NotesMaterialsScreenState();
}

class _NotesMaterialsScreenState extends State<NotesMaterialsScreen> {
  final TextEditingController _search = TextEditingController();
  final List<String> categories = [
    'All',
    'Physics',
    'Chemistry',
    'Maths',
    'Biology',
    'GK',
  ];
  String selectedCat = 'All';
  bool grid = true;
  String sortKey = 'Latest';

  /// Dummy data — replace with API
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Mechanics Crash Notes',
      'subtitle': 'Physics • Class 11',
      'type': 'pdf', // pdf | doc | video | ppt
      'size': '12.4 MB',
      'pages': 54,
      'preview':
      'https://i.ytimg.com/vi/tS6gYRm-67I/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLArg8tGctk4dBRPSRRrllgsDA8utQ',
      'category': 'Physics',
      'updated': DateTime(2025, 11, 1),
      'isNew': true,
      'isDownloaded': false,
      'favorite': true,
      'tags': ['Kinematics', 'Laws',],
    },
    {
      'title': 'Organic Basic Formula Sheet',
      'subtitle': 'Chemistry • Quick Rev',
      'type': 'pdf',
      'size': '3.1 MB',
      'pages': 7,
      'preview':
      'https://i.ytimg.com/vi/-wEOh0M7dDA/hqdefault.jpg',
      'category': 'Chemistry',
      'updated': DateTime(2025, 10, 25),
      'isNew': false,
      'isDownloaded': true,
      'favorite': false,
      'tags': ['Organic', 'Basics'],
    },
    {
      'title': 'Integration Tricks',
      'subtitle': 'Maths • JEE Focus',
      'type': 'doc',
      'size': '480 KB',
      'pages': 10,
      'preview':
      'https://i.ytimg.com/vi/5ETpu4yaG94/sddefault.jpg',
      'category': 'Maths',
      'updated': DateTime(2025, 10, 28),
      'isNew': true,
      'isDownloaded': false,
      'favorite': true,
      'tags': ['Calculus', 'Shortcuts'],
    },
    {
      'title': 'Cell Structure Diagram Pack',
      'subtitle': 'Biology • Labeled',
      'type': 'ppt',
      'size': '9.2 MB',
      'pages': 18,
      'preview':
      'https://i.ytimg.com/vi/zVFVoOEOhcw/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDBQEN0wVqS94KZbrdRd1tLQEjxNg',
      'category': 'Biology',
      'updated': DateTime(2025, 9, 14),
      'isNew': false,
      'isDownloaded': false,
      'favorite': false,
      'tags': ['Diagrams', 'Cells'],
    },
    {
      'title': 'Modern History One-Pager',
      'subtitle': 'GK • Freedom Struggle',
      'type': 'pdf',
      'size': '1.8 MB',
      'pages': 2,
      'preview':
      'https://www.adda247.com/jobs/wp-content/uploads/sites/15/2024/12/05140912/Modern-History-Indian-National-Congress-Sessions-One-liner-Questions-for-All-Competitive-Exams.png',
      'category': 'GK',
      'updated': DateTime(2025, 11, 5),
      'isNew': true,
      'isDownloaded': true,
      'favorite': false,
      'tags': ['Modern', 'Dates'],
    },
    {
      'title': 'Electrostatics Concept Video',
      'subtitle': 'Physics • 20 min',
      'type': 'video',
      'size': 'HD',
      'pages': 0,
      'preview':
      'https://i.ytimg.com/vi/le2vYj0EaZ0/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAagp9Qy3rFL8PpB9ZBHj3EmcYqeg',
      'category': 'Physics',
      'updated': DateTime(2025, 10, 30),
      'isNew': false,
      'isDownloaded': false,
      'favorite': false,
      'tags': ['Charges', 'Fields'],
    },
  ];

  List<Map<String, dynamic>> get filtered {
    final q = _search.text.trim().toLowerCase();
    List<Map<String, dynamic>> list = items.where((e) {
      final okCat = selectedCat == 'All' || e['category'] == selectedCat;
      final okQ = q.isEmpty ||
          e['title'].toString().toLowerCase().contains(q) ||
          e['subtitle'].toString().toLowerCase().contains(q) ||
          (e['tags'] as List).join(' ').toLowerCase().contains(q);
      return okCat && okQ;
    }).toList();

    list.sort((a, b) {
      switch (sortKey) {
        case 'A-Z':
          return a['title'].toString().compareTo(b['title'].toString());
        case 'Size':
          return _sizeInKB(a['size']).compareTo(_sizeInKB(b['size']));
        default:
          return (b['updated'] as DateTime).compareTo(a['updated'] as DateTime);
      }
    });
    return list;
  }

  int _sizeInKB(String s) {
    final parts = s.split(' ');
    if (parts.length < 2) return 0;
    final numVal = double.tryParse(parts.first.replaceAll(RegExp('[^0-9\\.]'), '')) ?? 0;
    final unit = parts[1].toUpperCase();
    if (unit.startsWith('KB')) return (numVal).round();
    if (unit.startsWith('MB')) return (numVal * 1024).round();
    if (unit.startsWith('GB')) return (numVal * 1024 * 1024).round();
    if (s == 'HD') return 9999999; // for video quality placeholder
    return 0;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Notes & Study Material',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor:AppColors.navyBlue,
        centerTitle: false,
        actions: [
          _SortButton(
            value: sortKey,
            onChanged: (v) => setState(() => sortKey = v),
          ),
          SizedBox(width: 4.sp,),
          IconButton(
            onPressed: () => setState(() => grid = !grid),
            icon: Container(
              // height: 30.sp,
              // width:  30.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.sp)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  grid ? Icons.view_list_rounded : Icons.grid_view_rounded,
                  color: AppColors.navyBlue,
                  size: 22.sp,
                ),
              ),
            ),
            tooltip: grid ? 'List View' : 'Grid View',
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 12.w),
          //   child: GestureDetector(
          //     onTap: () => setState(() => grid = !grid),
          //     child: AnimatedContainer(
          //       duration: const Duration(milliseconds: 300),
          //       curve: Curves.easeInOut,
          //       width: 90.w,
          //       height: 36.h,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(30.r),
          //         color: Colors.white,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.2),
          //             blurRadius: 6,
          //             offset: const Offset(0, 3),
          //           ),
          //         ],
          //       ),
          //       child: Stack(
          //         alignment: Alignment.center,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Expanded(
          //                 child: Icon(
          //                   Icons.grid_view_rounded,
          //                   color: grid ? Colors.white : Colors.black,
          //                   size: 20.sp,
          //                 ),
          //               ),
          //               Expanded(
          //                 child: Icon(
          //                   Icons.view_list_rounded,
          //                   color: !grid ? Colors.white : Colors.black,
          //                   size: 20.sp,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           AnimatedAlign(
          //             alignment: grid
          //                 ? Alignment.centerLeft
          //                 : Alignment.centerRight,
          //             duration: const Duration(milliseconds: 300),
          //             curve: Curves.easeInOut,
          //             child: Container(
          //               margin: EdgeInsets.symmetric(horizontal: 5.w),
          //               width: 38.w,
          //               height: 30.h,
          //               decoration: BoxDecoration(
          //                 color: AppColors.navyBlue,
          //                 borderRadius: BorderRadius.circular(25.r),
          //               ),
          //               child: Icon(
          //                 grid
          //                     ? Icons.grid_view_rounded
          //                     : Icons.view_list_rounded,
          //                 size: 20.sp,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10.sp,
            ),

            SizedBox(
              height: 45.sp,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                            hintText: 'Search notes, tags, topics…',
                            hintStyle: TextStyle(color: Colors.white70, fontSize: 12.5.sp),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (_search.text.isNotEmpty)
                        GestureDetector(
                          onTap: () { _search.clear(); setState(() {}); },
                          child: const Icon(Icons.close_rounded, color: Colors.white70),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Categories
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
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        gradient: sel
                            ? const LinearGradient(colors: [AppColors3.mint, AppColors3.sky])
                            : const LinearGradient(colors: [Color(0x22FFFFFF), Color(0x11FFFFFF)]),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: sel ? Colors.transparent : Colors.white24),
                      ),
                      child: Row(
                        children: [
                          Icon(sel ? Icons.check_circle_rounded : Icons.circle, size: 14.sp, color: sel ? Colors.white : Colors.white54),
                          SizedBox(width: 8.w),
                          Text(c, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.5.sp)),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemCount: categories.length,
              ),
            ),

            // List/Grid
            SizedBox(height: 18.h),
            Expanded(
              child: filtered.isEmpty
                  ? Center(child: Text('No materials found', style: TextStyle(color: Colors.white70, fontSize: 13.sp)))
                  : AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: grid
                    ? _Grid(sets: filtered, onOpen: _openDetails, onToggleFav: _toggleFav, onDownload: _downloadAction)
                    : _List(sets: filtered, onOpen: _openDetails, onToggleFav: _toggleFav, onDownload: _downloadAction),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFav(Map<String, dynamic> m) => setState(() => m['favorite'] = !(m['favorite'] as bool));
  void _downloadAction(Map<String, dynamic> m) => setState(() => m['isDownloaded'] = true);

  void _openDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MaterialDetailsSheet(
        item: item,
        onDownload: () => _downloadAction(item),
        onFavorite: () => _toggleFav(item),
        onOpen: () {
          Navigator.pop(context);
          // TODO: Navigate to viewer screen (PDF/Doc/Video)
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open/view tapped')));
        },
      ),
    );
  }
}

/// ============================================================
/// WIDGETS
/// ============================================================
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
        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 12, offset: Offset(0, 6))],
      ),
      child: child,
    );
  }
}

class _SortButton extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _SortButton({required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: const Color(0xFF1F2937),
      elevation: 6,
      onSelected: onChanged,
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'Latest', child: Text('Latest', style: TextStyle(color: Colors.white))),
        PopupMenuItem(value: 'A-Z', child: Text('A-Z', style: TextStyle(color: Colors.white))),
        PopupMenuItem(value: 'Size', child: Text('Size (small → big)', style: TextStyle(color: Colors.white))),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppColors3.royalBlue, AppColors3.sky]),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(children: [
          const Icon(Icons.sort_rounded, color: Colors.white, size: 16),
          SizedBox(width: 6.w),
          Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.5.sp)),
        ]),
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  final List<Map<String, dynamic>> sets;
  final void Function(Map<String, dynamic>) onOpen;
  final void Function(Map<String, dynamic>) onToggleFav;
  final void Function(Map<String, dynamic>) onDownload;
  const _Grid({required this.sets, required this.onOpen, required this.onToggleFav, required this.onDownload});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(10.w, 4.h, 10.w, 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (ScreenUtil().screenWidth > 480) ? 3 : 2,
        crossAxisSpacing: 5.w,
        mainAxisSpacing: 5.h,
        childAspectRatio: 0.7,
      ),
      itemCount: sets.length,
      itemBuilder: (_, i) => _MaterialCardGrid(
          data: sets[i], onTap: onOpen, onToggleFav: onToggleFav, onDownload: onDownload, listStyle: false),
    );
  }
}

class _List extends StatelessWidget {
  final List<Map<String, dynamic>> sets;
  final void Function(Map<String, dynamic>) onOpen;
  final void Function(Map<String, dynamic>) onToggleFav;
  final void Function(Map<String, dynamic>) onDownload;
  const _List({required this.sets, required this.onOpen, required this.onToggleFav, required this.onDownload});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(10.w, 4.h, 10.w, 10.h),
      itemCount: sets.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (_, i) => _MaterialCard(
          data: sets[i], onTap: onOpen, onToggleFav: onToggleFav, onDownload: onDownload, listStyle: true),
    );
  }
}

class _MaterialCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool listStyle;
  final void Function(Map<String, dynamic>) onTap;
  final void Function(Map<String, dynamic>) onToggleFav;
  final void Function(Map<String, dynamic>) onDownload;

  const _MaterialCard({
    required this.data,
    required this.onTap,
    required this.onToggleFav,
    required this.onDownload,
    this.listStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    final isNew = data['isNew'] == true;
    final isDownloaded = data['isDownloaded'] == true;
    final favorite = data['favorite'] == true;

    final header = _Preview(
      type: data['type'],
      image: data['preview'],
      pages: data['pages'],
      isNew: isNew,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data['title'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 13.5.sp, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data['subtitle'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: 11.5.sp),
            ),

            if (isDownloaded)
              _statusPill(Icons.check_circle_rounded, 'Saved')
            else
              _statusPill(Icons.cloud_download_rounded, 'Cloud'),
          ],
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: (data['tags'] as List).take(3).map<Widget>((t) => _tagChip(t)).toList(),
        ),

        SizedBox(height: 5.h),
        Row(
          children: [
            _pill(_typeIcon(data['type']), data['type'].toString().toUpperCase()),
            SizedBox(width: 4.w),
            _pill(Icons.storage_rounded, data['size']),
            // const Spacer(),
            SizedBox(width: 4.w),

            _iconBtn(
              tooltip: isDownloaded ? 'Open' : 'Download',
              icon: isDownloaded ? Icons.open_in_new_rounded : Icons.download_rounded,
              onTap: () => isDownloaded ? onTap(data) : onDownload(data),
            ),
            SizedBox(width: 4.w),

            _iconBtn(
              tooltip: 'More',
              icon: Icons.more_horiz_rounded,
              onTap: () => onTap(data),
            ),

          ],
        ),
        SizedBox(height: 5.h),



      ],
    );


    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppColors3.cardGrad1, AppColors3.cardGrad2]),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.white12, width: 1),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 16, offset: Offset(0, 8))],
        ),
        child:

        Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)),
                  child: SizedBox(width: 120.w, height: 130.h, child: header),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconBtn(
                      tooltip: favorite ? 'Unfavorite' : 'Favorite',
                      icon: favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      onTap: () => onToggleFav(data),
                    ),

                  ],
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    content,
                  ],
                ),
              ),
            )
          ],
        )

      ),
    );
  }

  Widget _iconBtn({required IconData icon, required VoidCallback onTap, String? tooltip}) {
    return Tooltip(
      message: tooltip ?? '',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.white24),
          ),
          child: Icon(icon, color: Colors.white, size: 18.sp),
        ),
      ),
    );
  }

  IconData _typeIcon(String t) {
    switch (t) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'doc':
        return Icons.description_rounded;
      case 'ppt':
        return Icons.slideshow_rounded;
      case 'video':
        return Icons.play_circle_fill_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Widget _pill(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Row(children: [
        Icon(icon, size: 12.sp, color: Colors.white70),
        SizedBox(width: 6.w),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 11.sp)),
      ]),
    );
  }

  Widget _statusPill(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors3.mint, AppColors3.sky]),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(children: [
        Icon(icon, size: 12.sp, color: Colors.black),
        SizedBox(width: 6.w),
        Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 10.5.sp)),
      ]),
    );
  }

  Widget _tagChip(String t) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white24),
      ),
      child: Text('#$t', style: TextStyle(color: Colors.white70, fontSize: 10.5.sp)),
    );
  }
}






class _MaterialCardGrid extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool listStyle;
  final void Function(Map<String, dynamic>) onTap;
  final void Function(Map<String, dynamic>) onToggleFav;
  final void Function(Map<String, dynamic>) onDownload;

  const _MaterialCardGrid({
    required this.data,
    required this.onTap,
    required this.onToggleFav,
    required this.onDownload,
    this.listStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    final isNew = data['isNew'] == true;
    final isDownloaded = data['isDownloaded'] == true;
    final favorite = data['favorite'] == true;

    final header = _Preview(
      type: data['type'],
      image: data['preview'],
      pages: data['pages'],
      isNew: isNew,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data['title'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 13.5.sp, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data['subtitle'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: 11.5.sp),
            ),

          ],
        ),
        SizedBox(height: 4.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: (data['tags'] as List).take(3).map<Widget>((t) => _tagChip(t)).toList(),
        ),




      ],
    );

    final actions = Row(
      children: [
        if (isDownloaded)
          Padding(
            padding:  EdgeInsets.only(right: 5.sp),
            child: _statusPill(Icons.check_circle_rounded, 'Saved'),
          )
        else
          Padding(
            padding:  EdgeInsets.only(right: 5.sp),
            child: _statusPill(Icons.cloud_download_rounded, 'Cloud'),
          ),
        SizedBox(width: 8.w),
        _iconBtn(
          tooltip: isDownloaded ? 'Open' : 'Download',
          icon: isDownloaded ? Icons.open_in_new_rounded : Icons.download_rounded,
          onTap: () => isDownloaded ? onTap(data) : onDownload(data),
        ),
        const Spacer(),
        _iconBtn(
          tooltip: 'More',
          icon: Icons.more_horiz_rounded,
          onTap: () => onTap(data),
        ),
      ],
    );

    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppColors3.cardGrad1, AppColors3.cardGrad2]),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white12, width: 1),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 16, offset: Offset(0, 8))],
        ),
        child:

        Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                  child: SizedBox(height: 120.h, width: double.infinity, child: header),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconBtn(
                      tooltip: favorite ? 'Unfavorite' : 'Favorite',
                      icon: favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      onTap: () => onToggleFav(data),
                    ),

                    Card(
                      color: Colors.black26,
                        child: _pill(Icons.storage_rounded, data['size'])),



                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [content, SizedBox(height: 10.h), actions],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn({required IconData icon, required VoidCallback onTap, String? tooltip}) {
    return Tooltip(
      message: tooltip ?? '',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white24),
          ),
          child: Icon(icon, color: Colors.white, size: 18.sp),
        ),
      ),
    );
  }

  IconData _typeIcon(String t) {
    switch (t) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'doc':
        return Icons.description_rounded;
      case 'ppt':
        return Icons.slideshow_rounded;
      case 'video':
        return Icons.play_circle_fill_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Widget _pill(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Row(children: [
        Icon(icon, size: 12.sp, color: Colors.white70),
        SizedBox(width: 6.w),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 11.sp)),
      ]),
    );
  }

  Widget _statusPill(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors3.mint, AppColors3.sky]),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(children: [
        Icon(icon, size: 12.sp, color: Colors.black),
        SizedBox(width: 6.w),
        Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 10.5.sp)),
      ]),
    );
  }

  Widget _tagChip(String t) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white24),
      ),
      child: Text('#$t', style: TextStyle(color: Colors.white70, fontSize: 10.5.sp)),
    );
  }
}

class _Preview extends StatelessWidget {
  final String type;
  final String image;
  final int pages;
  final bool isNew;
  const _Preview({required this.type, required this.image, required this.pages, required this.isNew});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // image / thumbnail
        Image.network(image, fit: BoxFit.cover,height: 200.sp,width: double.infinity,
            loadingBuilder: (c, w, ev) => ev == null ? w : Container(color: Colors.white12)),
        // overlay
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.55)],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
        ),
        // type + page badge
        Positioned(
          left: 8.w, bottom: 8.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(children: [
              Icon(_typeIcon(type), size: 12.sp, color: Colors.black),
              SizedBox(width: 6.w),
              Text(type.toUpperCase(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 10.5.sp)),
              if (pages != 0) ...[
                SizedBox(width: 6.w),
                Text('• $pages p', style: TextStyle(color: Colors.black87, fontSize: 10.5.sp)),
              ],
            ]),
          ),
        ),
        if (type == 'video')
          const Positioned(right: 8, bottom: 8, child: Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 28)),
        if (isNew)
          Positioned(left: 8.w, top: 8.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: AppColors3.pink, borderRadius: BorderRadius.circular(8.r)),
              child: Text('NEW', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 10.sp)),
            ),
          ),
      ],
    );
  }

  IconData _typeIcon(String t) {
    switch (t) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'doc':
        return Icons.description_rounded;
      case 'ppt':
        return Icons.slideshow_rounded;
      case 'video':
        return Icons.play_circle_fill_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }
}

class _MaterialDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onDownload;
  final VoidCallback onFavorite;
  final VoidCallback onOpen;

  const _MaterialDetailsSheet({
    required this.item,
    required this.onDownload,
    required this.onFavorite,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final favorite = item['favorite'] == true;
    final downloaded = item['isDownloaded'] == true;

    // return DraggableScrollableSheet(
    //   initialChildSize: 0.82,
    //   minChildSize: 0.5,
    //   maxChildSize: 0.92,
    //   builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors3.navyBlue,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            border: Border.all(color: Colors.white12),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: Container(
                      width: 46.w, height: 5.h,
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(999)),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: _Preview(
                          type: item['type'], image: item['preview'], pages: item['pages'], isNew: item['isNew'] == true),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(item['title'],
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18.sp)),
                        ),
                        _roundIcon(
                          icon: favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          onTap: onFavorite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(item['subtitle'], style: TextStyle(color: Colors.white70, fontSize: 13.5.sp)),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Wrap(spacing: 6.w, runSpacing: 6.h,
                      children: (item['tags'] as List).map<Widget>((t) => _tag(t)).toList(),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      height: 50.sp,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _info(Icons.category_rounded, item['category']),
                          SizedBox(width: 8.w),
                          if (item['pages'] != 0) _info(Icons.description_rounded, '${item['pages']} pages'),
                          SizedBox(width: 8.w),
                          _info(Icons.storage_rounded, item['size']),
                          SizedBox(width: 8.w),
                          _info(Icons.update_rounded, '${_prettyDate(item['updated'])}'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors3.mint, foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                            ),
                            onPressed: onOpen,
                            icon: const Icon(Icons.open_in_new_rounded),
                            label: Text('Open / View', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5.sp)),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                            ),
                            onPressed: downloaded ? null : onDownload,
                            icon: Icon(downloaded ? Icons.check_circle_rounded : Icons.download_rounded),
                            label: Text(downloaded ? 'Saved' : 'Download'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),

                ],
              ),
            ),
          ),
        );
  //    },
 //   );
  }

  String _prettyDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Widget _info(IconData i, String t) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.white24),
    ),
    child: Row(children: [
      Icon(i, color: Colors.white70, size: 14.sp),
      SizedBox(width: 6.w),
      Text(t, style: const TextStyle(color: Colors.white)),
    ]),
  );

  Widget _roundIcon({required IconData icon, required VoidCallback onTap}) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12.r),
    child: Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white24),
      ),
      child: Icon(icon, color: Colors.white),
    ),
  );

  Widget _tag(String t) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: Colors.white24),
    ),
    child: Text('#$t', style: const TextStyle(color: Colors.white70)),
  );
}









