import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/notification/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationItem>[
    NotificationItem(
      id: '1',
      title: "Welcome!",
      message: "Thank you for joining our platform.",
      time: "Just now",
      icon: Icons.notifications_active,
    ),
    NotificationItem(
      id: '2',
      title: "Profile Updated",
      message: "Your profile info was updated successfully.",
      time: "2h ago",
      icon: Icons.person,
    ),
    NotificationItem(
      id: '3',
      title: "New Message",
      message: "You received a new message from Ken.",
      time: "1d ago",
      icon: Icons.message,
    ),
    NotificationItem(
      id: '4',
      title: "Event Reminder",
      message: "Don't forget the team meeting tomorrow.",
      time: "3d ago",
      icon: Icons.event_note,
    ),
  ].obs;

  void deleteNotification(String id) {
    notifications.removeWhere((notification) => notification.id == id);
  }

  void deleteAllNotifications() {
    notifications.clear();
  }
}
