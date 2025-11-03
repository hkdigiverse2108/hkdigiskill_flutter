import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/notification/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationItem>[
    NotificationItem(
      title: "Welcome!",
      message: "Thank you for joining our platform.",
      time: "Just now",
      icon: Icons.notifications_active,
    ),
    NotificationItem(
      title: "Profile Updated",
      message: "Your profile info was updated successfully.",
      time: "2h ago",
      icon: Icons.person,
    ),
    NotificationItem(
      title: "New Message",
      message: "You received a new message from Ken.",
      time: "1d ago",
      icon: Icons.message,
    ),
    NotificationItem(
      title: "Event Reminder",
      message: "Don’t forget the team meeting tomorrow.",
      time: "3d ago",
      icon: Icons.event_note,
    ),
  ].obs;
}
