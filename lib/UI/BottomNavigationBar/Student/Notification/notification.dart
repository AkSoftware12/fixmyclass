import 'package:fixmyclass/Utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_details.dart';
import 'notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, String>> notifications = [];
  Set<String> readNotifications = {}; // 🔹 store read IDs or titles

  @override
  void initState() {
    super.initState();
    NotificationService.init();
    _loadNotifications();
    _loadReadStatus();
  }

  Future<void> _loadNotifications() async {
    notifications = await NotificationService.getNotifications();
    setState(() {});
  }

  Future<void> _loadReadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    readNotifications =
        prefs.getStringList('readNotifications')?.toSet() ?? {};
    setState(() {});
  }

  Future<void> _markAsRead(String id) async {
    final prefs = await SharedPreferences.getInstance();
    readNotifications.add(id);
    await prefs.setStringList('readNotifications', readNotifications.toList());
    setState(() {});
  }

  bool _isRead(String id) => readNotifications.contains(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Notifications",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () async {
              await _loadNotifications();
              await _loadReadStatus();
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
        child: Text(
          "No notifications yet!",
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(10.w),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final data = notifications[index];
          final id = data["id"] ?? data["title"] ?? "$index";
          final imageUrl = data["image"];
          final isRead = _isRead(id);

          return GestureDetector(
            onTap: () {
              _markAsRead(id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationDetailScreen(data: data),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xffeaf3ff)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w, vertical: 6.h),
                leading: imageUrl != null && imageUrl.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    imageUrl,
                    height: 55.sp,
                    width: 55.sp,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image,
                        color: Colors.grey, size: 40),
                  ),
                )
                    : Container(
                  height: 55.sp,
                  width: 55.sp,
                  decoration: BoxDecoration(
                    color: AppColors.navyBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: AppColors.navyBlue,
                    size: 30.sp,
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data["title"] ?? "No title",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: AppColors.navyBlue,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    if (!isRead)
                      Container(
                        margin: EdgeInsets.only(left: 6.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    data["body"] ?? "No message",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: AppColors.navyBlue,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
