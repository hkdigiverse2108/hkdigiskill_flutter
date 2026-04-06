import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/modules/notification/controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

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
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Obx(
                () =>
            controller.notifications.isNotEmpty
                ? TextButton(
              onPressed: controller.deleteAllNotifications,
              child: Text(
                "Clear All",
                style: TextStyle(color: Colors.red),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load notifications',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: controller.loadNotifications,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!controller.hasNotifications) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined,
                      size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    controller.emptyMessage,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await controller.loadNotifications();
            },
            child: ListView.separated(
              itemCount: controller.notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, idx) {
                final noti = controller.notifications[idx];
                return Dismissible(
                  key: Key(noti.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) =>
                      controller.deleteNotification(noti.id),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme
                          .of(context)
                          .primaryColor,
                      child: Icon(
                        noti.icon ?? Icons.notifications,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      noti.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          noti.message,
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          noti.time,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle notification tap
                      // Get.to(() => NotificationDetail(notification: noti));
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}