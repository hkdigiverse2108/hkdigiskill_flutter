import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/modules/notification/controllers/notification_controller.dart';

class Notification extends GetView<NotificationController> {
  const Notification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Clear All", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Obx(
        () => controller.notifications.isEmpty
            ? Center(
                child: Text(
                  'No notifications!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 18),
                ),
              )
            : ListView.separated(
                itemCount: controller.notifications.length,
                separatorBuilder: (_, __) => Gap(1),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                itemBuilder: (context, idx) {
                  final noti = controller.notifications[idx];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      // backgroundColor: Colors.blue,
                      radius: 28,
                      child: Icon(
                        noti.icon ?? Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      noti.title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      noti.message,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Text(
                      noti.time,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {}, // Optionally add navigation or detail actions
                  );
                },
              ),
      ),
    );
  }
}
