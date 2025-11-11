import 'dart:async';
import 'dart:ui';
import 'package:fixmyclass/Utils/HexColorCode/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utils/color.dart';

class LiveSlot {
  final DateTime start, end;
  LiveSlot({required this.start, required this.end});
  bool contains(DateTime t) => !t.isBefore(start) && !t.isAfter(end);
}

class LiveClass {
  final String title, teacher, image,liveurl;
  final List<LiveSlot> slots;
  LiveClass({
    required this.title,
    required this.teacher,
    required this.image,
    required this.liveurl,
    required this.slots,
  });
}

class LiveClassScreen extends StatefulWidget {
  final String appBar;

  const LiveClassScreen({super.key, required this.appBar});
  @override
  State<LiveClassScreen> createState() => _LiveClassScreenState();
}

class _LiveClassScreenState extends State<LiveClassScreen> {
  late Timer _timer;
  DateTime _now = DateTime.now();
  bool isGridView = false;


  DateTime _todayAt(int h, int m) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day, h, m);
  }

  final List<LiveClass> classes = [];

  @override
  void initState() {
    super.initState();
    classes.addAll([
      LiveClass(
        title: 'Physics – Wave Optics',
        teacher: 'Anita Sharma',
        image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcQZputUgPcBlbgE5ahOBwRIxOk-7EAFVbwQ&s',
        slots: [
          LiveSlot(start: _todayAt(00, 0), end: _todayAt(23, 59)),
          LiveSlot(start: _todayAt(18, 0), end: _todayAt(19, 0)),
        ],
        liveurl: 'https://www.youtube.com/watch?v=3GQeTy00AhQ',
      ),
      LiveClass(
        title: 'Chemistry – Organic Basics',
        teacher: 'Rahul Verma',
        image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXIQkWBbH_CYDDEFL-clbpWZETvGXufQpjTw&s',
        slots: [
          LiveSlot(start: _todayAt(11, 0), end: _todayAt(12, 0)),
          LiveSlot(start: _todayAt(20, 0), end: _todayAt(21, 0)),
        ],
        liveurl: '',

      ),
      LiveClass(
        title: 'Mathematics – Integrals',
        teacher: 'R. Iyer',
        image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPEBerqQpB-cfA76mdUUsetyHGn5f5GahmHQ&s',
        slots: [
          LiveSlot(start: _todayAt(8, 30), end: _todayAt(9, 30)),
          LiveSlot(start: _todayAt(16, 0), end: _todayAt(17, 0)),
        ],
        liveurl: '',

      ),

      LiveClass(
        title: 'Mathematics – Integrals',
        teacher: 'R. Iyer',
        image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2ccipCLYRPcFIIAxaZs-XLPOG4VfA66vr0A&s',
        slots: [
          LiveSlot(start: _todayAt(8, 30), end: _todayAt(9, 30)),
          LiveSlot(start: _todayAt(16, 0), end: _todayAt(17, 0)),
        ],
        liveurl: '',

      ),

      LiveClass(
        title: 'Mathematics – Integrals',
        teacher: 'R. Iyer',
        image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFZeAFU_lLUn5QMZdoPv1uHSMoFwU63dLXnCTwtUwUWwYCkvRevwTQmOVkWtkcHvQ-MIM&usqp=CAU',
        slots: [
          LiveSlot(start: _todayAt(8, 30), end: _todayAt(9, 30)),
          LiveSlot(start: _todayAt(16, 0), end: _todayAt(17, 0)),
        ],
        liveurl: '',

      ),

      LiveClass(
        title: 'Mathematics – Integrals',
        teacher: 'R. Iyer',
        image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3ooIg7uOLEU6oBtEwz9vym6yoWraFql8hMA&s',
        slots: [
          LiveSlot(start: _todayAt(8, 30), end: _todayAt(9, 30)),
          LiveSlot(start: _todayAt(16, 0), end: _todayAt(17, 0)),
        ],
        liveurl: '',

      ),
    ]);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  LiveSlot? _activeSlot(LiveClass c) =>
      c.slots.where((s) => s.contains(_now)).firstOrNull;

  bool _isLive(LiveClass c) => _activeSlot(c) != null;

  LiveSlot? _nextSlot(LiveClass c) {
    final f = c.slots.where((s) => s.start.isAfter(_now)).toList()
      ..sort((a, b) => a.start.compareTo(b.start));
    return f.isNotEmpty ? f.first : null;
  }

  String _fmtTime(DateTime t) {
    final hh = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final mm = t.minute.toString().padLeft(2, '0');
    final ampm = t.hour >= 12 ? 'PM' : 'AM';
    return '$hh:$mm $ampm';
  }

  String _durationStr(Duration d) {
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (d.inHours > 0) return '${d.inHours}h ${m}m';
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D1117),

      // 🔹 Floating Action Button for Grid/List Toggle
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 12.h, right: 12.w),
        child: GestureDetector(
          onTap: () => setState(() => isGridView = !isGridView),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 90.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
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
                  alignment:
                  isGridView ? Alignment.centerLeft : Alignment.centerRight,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    width: 40.w,
                    height: 32.h,
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

      body: Column(
        children: [
          Expanded(
            child: classes.isEmpty
                ? Center(
              child: Text(
                "No live class 😔",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500),
              ),
            )
                : isGridView
                ? Padding(
    padding: EdgeInsets.all(5.w),
    child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10.w,
    mainAxisSpacing: 10.h,
    childAspectRatio: 1.1,
    ),
    itemCount: classes.length,
    itemBuilder: (context, i) {
    final c = classes[i];
    final live = _isLive(c);
    final active = _activeSlot(c);
    final next = _nextSlot(c);

    final status = live
    ? 'LIVE • Ends in ${_durationStr(active!.end.difference(_now))}'
        : next != null
    ? 'Starts at ${_fmtTime(next.start)}'
        : 'Finished';

    return _GridLiveCard(
    image: c.image,
    title: c.title,
    teacher: c.teacher,
    status: status,
    isLive: live,
    onViewSlots: () => _showSlots(context, c),
    );
    },
    ),
    )

        : ListView.builder(
              padding: EdgeInsets.all(5.w),
              itemCount: classes.length,
              itemBuilder: (context, i) {
                final c = classes[i];
                final live = _isLive(c);
                final active = _activeSlot(c);
                final next = _nextSlot(c);

                final status = live
                    ? 'LIVE • Ends in ${_durationStr(active!.end.difference(_now))}'
                    : next != null
                    ? 'Starts at ${_fmtTime(next.start)}'
                    : 'All slots finished';

                return _LiveCard(
                  image: c.image,
                  title: c.title,
                  teacher: c.teacher,
                  status: status,
                  isLive: live,
                  onViewSlots: () => _showSlots(context, c),
                  onJoin: live
                      ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.black87,
                        content: Text('Joining ${c.title}...'),
                      ),
                    );
                  }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSlots(BuildContext context, LiveClass c) {
    showModalBottomSheet(
      backgroundColor: const Color(0xff0E1530),
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      context: context,
      builder: (_) => ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 18.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  c.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp,
                  ),
                ),
                Divider(color: Colors.white12, height: 22.h),
                ...c.slots.asMap().entries.map(
                      (e) => Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(14.r),
                      border:
                      Border.all(color: Colors.white12, width: 1.sp),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time,
                            color: Colors.lightBlueAccent),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Slot ${e.key + 1}: ${_fmtTime(e.value.start)} — ${_fmtTime(e.value.end)}',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13.sp),
                          ),
                        ),
                      ],
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

class _GridLiveCard extends StatelessWidget {
  final String image, title, teacher, status;
  final bool isLive;
  final VoidCallback onViewSlots;

  const _GridLiveCard({
    required this.image,
    required this.title,
    required this.teacher,
    required this.status,
    required this.isLive,
    required this.onViewSlots,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewSlots,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: isLive
                  ? Colors.redAccent.withOpacity(.25)
                  : Colors.blueAccent.withOpacity(.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Stack(
            children: [
              Image.network(
                image,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 2.h,
                right: 2.w,
                child: isLive
                    ? const _LiveBadge()
                    : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50.r),
                    border:
                    Border.all(color: Colors.white24, width: 1.sp),
                  ),
                  child: Text(
                    'UPCOMING',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.20),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20.r)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 0.h),

                      Text(
                        teacher,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            status,
                            style: TextStyle(
                              color: isLive
                                  ? Colors.redAccent
                                  : Colors.lightBlueAccent,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                            width: 20.sp,
                            child: IconButton(
                                onPressed: onViewSlots,
                              icon:  Icon(Icons.more_vert, size: 15, color: Colors.white70),
                            )

                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveBadge extends StatefulWidget {
  const _LiveBadge();
  @override
  State<_LiveBadge> createState() => _LiveBadgeState();
}

class _LiveBadgeState extends State<_LiveBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: .55, end: 1.0).animate(_c),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [HexColor('#FF0000'), HexColor('#FF0000')]),
          borderRadius: BorderRadius.circular(50.r),
          boxShadow: [
            BoxShadow(color: Colors.redAccent.withOpacity(.30), blurRadius: 14, spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle, color: Colors.white, size: 8.sp),
            SizedBox(width: 4.w),
            Text('LIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  fontSize: 10.5.sp,
                )),
          ],
        ),
      ),
    );
  }
}



class _LiveCard extends StatefulWidget {
  final String image, title, teacher, status;
  final bool isLive;
  final VoidCallback? onJoin;
  final VoidCallback onViewSlots;
  const _LiveCard({
    required this.image,
    required this.title,
    required this.teacher,
    required this.status,
    required this.isLive,
    required this.onViewSlots,
    required this.onJoin,
  });

  @override
  State<_LiveCard> createState() => _LiveCardState();
}

class _LiveCardState extends State<_LiveCard> with SingleTickerProviderStateMixin {
  late final AnimationController _entry =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 650))
    ..forward();

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _entry, curve: Curves.easeOutCubic),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, .06), end: Offset.zero)
            .animate(CurvedAnimation(parent: _entry, curve: Curves.easeOutCubic)),
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.r),
            // Neon border glow
            boxShadow: [
              BoxShadow(
                color: widget.isLive
                    ? Colors.redAccent.withOpacity(.35)
                    : Colors.blueAccent.withOpacity(.18),
                blurRadius: 22,
                spreadRadius: 1,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Stack(
              children: [
                // Background image
                Image.network(
                  widget.image,
                  height: 200.sp,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.isLive ? const _LiveBadge() : _UpcomingChip(),
                      ],
                    ),
                  ),
                ),

                // Glass bottom panel
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.42),
                      border: Border(
                        top: BorderSide(color: Colors.white12, width: 1.sp),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + LIVE badge
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Teacher row with avatar initials
                        Row(
                          children: [
                            _CircleInitials(name: widget.teacher),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                widget.teacher,
                                style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              widget.status,
                              style: TextStyle(
                                color: widget.isLive ? Colors.redAccent : Colors.white70,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                              ),
                            ),

                            SizedBox(width: 10.w),
                            SizedBox(
                              height: 20.sp,
                              child: OutlinedButton.icon(
                                onPressed: widget.onViewSlots,
                                icon: const Icon(Icons.schedule_rounded, size: 15, color: Colors.white70),
                                label: Text('View Slots',
                                    style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.white24, width: 1.sp),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.h),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Status text


                      ],
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

class _UpcomingChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: Colors.white24, width: 1.sp),
      ),
      child: Text('UPCOMING', style: TextStyle(color: Colors.white70, fontSize: 11.sp,fontWeight: FontWeight.w700)),
    );
  }
}

class _CircleInitials extends StatelessWidget {
  final String name;
  const _CircleInitials({required this.name});

  @override
  Widget build(BuildContext context) {
    final parts = name.trim().split(' ');
    final initials =
    parts.length == 1 ? parts.first.characters.first : (parts[0].characters.first + parts[1].characters.first);
    return Container(
      width: 20.w,
      height: 20.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(colors: [Color(0xFF4b6cb7), Color(0xFF182848)]),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.4), blurRadius: 6)],
      ),
      child: Text(initials.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w800)),
    );
  }
}