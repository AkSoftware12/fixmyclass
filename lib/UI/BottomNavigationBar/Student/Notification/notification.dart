import 'package:flutter/material.dart';
import 'notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    NotificationService.init();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    notifications = await NotificationService.getNotifications();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📬 Notifications"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _loadNotifications();
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications yet!"))
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final data = notifications[index];
          final imageUrl = data["image"];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: imageUrl != null && imageUrl.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: 55,
                  width: 55,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image,
                      color: Colors.grey, size: 40),
                ),
              )
                  : const Icon(Icons.notifications_active,
                  color: Colors.blue, size: 40),
              title: Text(
                data["title"] ?? "No title",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  data["body"] ?? "No message",
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
